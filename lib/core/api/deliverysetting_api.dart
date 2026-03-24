import 'package:dio/dio.dart';

class DeliverySettingApi {
  final Dio dio;

  DeliverySettingApi(this.dio) {
    dio.options.baseUrl = "http://127.0.0.1:8000/api";
    dio.options.headers = {"Accept": "application/json"};
  }

  Future<Response> updateDeliverySettings({
    required String token,
    required double pricePerKm,
    required double minimumDeliveryFee,
  }) async {
    final data = {
      "price_per_km": pricePerKm,
      "minimum_delivery_fee": minimumDeliveryFee,
    };

    return await dio.post(
      "/admin/restaurant/updateDeliverySettings",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
