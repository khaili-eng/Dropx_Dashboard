import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';

abstract class AdminFeesRemoteDataSource {
  Future<List<FeeModel>> getadminMonthlyfeesfromdriver();
  Future<List<FeeModel>> getadminDailyfeesfromdriver();
  Future<List<FeeModel>> getAdminDailyEarningsFromRestaurants();
  Future<List<FeeModel>> getAdminMonthlyEarningsFromRestaurants();
}

class AdminFeesRemoteDataSourceImpl implements AdminFeesRemoteDataSource {
  Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;
  String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";
  @override
  Future<List<FeeModel>> getAdminDailyEarningsFromRestaurants() async {
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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FeeModel>> getAdminMonthlyEarningsFromRestaurants() async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAdminMonthlyEarningsFromRestaurants}",

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FeeModel>> getadminDailyfeesfromdriver() async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getadminDailyfeesfromdriver}",

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
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<FeeModel>> getadminMonthlyfeesfromdriver() async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getadminMonthlyfeesfromdriver}",

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
      throw ServerException(e.toString());
    }
  }
}
