import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient(String token)
    : dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
}
