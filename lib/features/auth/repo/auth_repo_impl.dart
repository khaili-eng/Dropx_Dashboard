import 'package:dio/dio.dart';
import 'package:maadati/core/constants/end_points/end_points.dart';
import 'package:maadati/core/network/api/api_error.dart';
import 'package:maadati/core/network/api/api_exceptions.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/core/utils/pref_helper.dart';
import 'package:maadati/features/auth/data/model/auth_response.dart';
import 'package:maadati/features/auth/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final ApiService apiService;
  AuthRepoImpl(this.apiService);
  //login
  Future<AuthResponse> login(String phone, String password) async {
    try {
      final response = await apiService.post(EndPoints.login, {
        "phone": phone,
        "password": password,
      });
      if (response == null) {
        throw ApiError(message: "Empty response from server");
      }
      final authResponse = AuthResponse.fromJson(response);
      //save token
      await PrefHelper.saveToken(authResponse.token);
      return authResponse;
    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
