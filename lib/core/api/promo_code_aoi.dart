import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';

class PromoCodeAoi {
  Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<PromoCodeModel>> fetchAllPromoCodes() async {
    String myToken = ApiConstants.myToken;

    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAllPromoCodes}",

        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => PromoCodeModel.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException("");
    }
  }
}
