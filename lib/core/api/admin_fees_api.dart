import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';

class AdminFeesApi {
  Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<List<FeeModel>> fetchAllOrders() async {
    String myToken = ApiConstants.myToken;

    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAdminDailyEarningsFromRestaurants}",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => FeeModel.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      print("Error Data: ${e.response?.data}");
      throw Exception("خطأ من السيرفر: ${e.response?.statusCode}");
    }
  }
}
