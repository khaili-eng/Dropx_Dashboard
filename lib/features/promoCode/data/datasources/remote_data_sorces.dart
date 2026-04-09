import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

class PromoRemoteDataSource {
  final Dio dio;

  PromoRemoteDataSource(this.dio);

  final String baseUrl = "http://127.0.0.1:8000/api/admin";
  final String myToken = "";

  Options _headers() {
    print("TOKEN => $myToken");
    return Options(
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $myToken',
      },
    );
  }

  Future<List<PromoCode>> getAll() async {
    try {
      final res = await dio.get("/getPromoCode");

      final model = PromoCodeResponse.fromJson(res.data);

      return model.data;
    } catch (e) {
      print("API ERROR => $e");
      rethrow;
    }
  }

  Future<void> add(PromoCode promo) async {
    try {
      final res = await dio.post("${ApiConstants.baseUrl}/AddPromoCode");
    } catch (e) {
      throw e;
    }
    await dio.post("$baseUrl/AddPromoCode", data: promo.toJson()  );
  }

  Future<void> delete(int id) async {
    await dio.delete("$baseUrl/DeletePromoCode/$id");
  }

  Future<void> update(PromoCode promo) async {
    await dio.put("$baseUrl/UpdatePromoCode/${promo.id}", data: promo.toJson());
  }
}
