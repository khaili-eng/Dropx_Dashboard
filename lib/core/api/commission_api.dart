import 'package:dio/dio.dart';

class CommissionApi {
  final Dio dio;

  CommissionApi({required String baseUrl, required String token})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

  Future<Response> addCommission({
    required int restaurantId,
    required String type,
    required int value,
  }) async {
    return dio.post(
      "/api/admin/restaurant/addcommission/$restaurantId",
      data: {"type": type, "value": value},
    );
  }

  Future<Response> updateCommission({
    required int id,
    required String type,
    required int value,
  }) async {
    return dio.post(
      "/api/admin/restaurant/updatecommission/$id",
      data: {"type": type, "value": value},
    );
  }
}
