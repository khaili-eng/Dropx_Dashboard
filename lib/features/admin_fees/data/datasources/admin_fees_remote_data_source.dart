import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/data/model/driver_fee_model.dart';
import 'package:maadati/features/admin_fees/data/model/restaurant_earning_model.dart';

abstract class AdminFeesRemoteDataSource {
  Future<List<DriverFeeModel>> getadminMonthlyfeesfromdriver(
    int year,
    int month,
  );
  Future<List<DriverFeeModel>> getadminDailyfeesfromdriver(
    int year,
    int month,
    int day,
  );
  Future<List<RestaurantEarningModel>> getAdminDailyEarningsFromRestaurants(
    int year,
  );
  Future<List<RestaurantEarningModel>> getAdminMonthlyEarningsFromRestaurants(
    int yrar,
    int month,
  );
}

class AdminFeesRemoteDataSourceImpl implements AdminFeesRemoteDataSource {
  final Dio dio;
  AdminFeesRemoteDataSourceImpl({required this.dio});
  final String baseUrl = ApiConstants.baseUrl;
  String myToken = ApiConstants.myToken;
  @override
  Future<List<RestaurantEarningModel>> getAdminDailyEarningsFromRestaurants(
    int year,
  ) async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAdminDailyEarningsFromRestaurants}/$year/",
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data
            .map((json) => RestaurantEarningModel.fromJson(json))
            .toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<RestaurantEarningModel>> getAdminMonthlyEarningsFromRestaurants(
    int year,
    int month,
  ) async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getAdminMonthlyEarningsFromRestaurants}/$year/$month",
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data
            .map((json) => RestaurantEarningModel.fromJson(json))
            .toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<DriverFeeModel>> getadminDailyfeesfromdriver(
    int year,
    int month,
    int day,
  ) async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getadminDailyfeesfromdriver}/$year/$month/$day",
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => DriverFeeModel.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<DriverFeeModel>> getadminMonthlyfeesfromdriver(
    int year,
    int month,
  ) async {
    try {
      final response = await dio.get(
        "$baseUrl/${ApiConstants.getadminMonthlyfeesfromdriver}/$year/$month",
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => DriverFeeModel.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw ServerException(e.toString());
    }
  }
}
