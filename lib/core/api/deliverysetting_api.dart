import 'package:dio/dio.dart';

class DeliverySettingApi {
  final Dio dio;

  DeliverySettingApi({required String baseUrl, required String token})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );
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
      "/api/admin/restaurant/updateDeliverySettings",
      data: data,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
