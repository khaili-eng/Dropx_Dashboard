import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/core/utils/service_locator.dart';

class AdminFeesApi {
  Dio dio = Dio();
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

class AuthInterceptor extends Interceptor {
  final String token;

  AuthInterceptor(this.token);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers['Authorization'] = 'Bearer $token';
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}

// في service_locator.dart عند تسجيل Dio
// ignore: use_function_type_syntax_for_parameters
void registerDioInstance() {
  sl.registerLazySingleton<Dio>(() {
    Dio dio = Dio();
    dio.interceptors.add(AuthInterceptor(ApiConstants.myToken));
    return dio;
  });
}
