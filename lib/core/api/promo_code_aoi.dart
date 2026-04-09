import 'package:dio/dio.dart';

class DioClient {
  final Dio dio = Dio();

  DioClient() {
    dio.options.baseUrl = "http://127.0.0.1:8000/api/admin/";

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = "1|o2DPf3OMgAs6uoXrvc69rcPCMAPATU6Tz4htJoEb6856278d";

          print("AUTO TOKEN => $token");

          options.headers["Accept"] = "application/json";

          if (token.isNotEmpty) {
            options.headers["Authorization"] = "Bearer $token";
          }

          return handler.next(options);
        },
      ),
    );
  }
}
