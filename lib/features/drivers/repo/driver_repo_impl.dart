import 'package:dio/dio.dart';
import 'package:maadati/core/network/api/api_service.dart';
import 'package:maadati/features/drivers/repo/driver_repo.dart';

import '../../../core/constants/end_points/end_points.dart';
import '../../../core/network/api/api_error.dart';
import '../../../core/network/api/api_exceptions.dart';
import '../data/model/driver_by_city_response.dart';
import '../data/model/driver_item_model.dart';
import '../data/model/driver_list_response.dart';
import '../data/model/driver_response_model.dart';
import '../data/model/turn_model.dart';
import '../data/model/working_hour_model.dart';

class DriverRepoImpl implements DriverRepo {
  final ApiService apiService;
  DriverRepoImpl(this.apiService);
  @override
  Future<DriverResponseModel> createDriver({
    required String fullname,
    required String phone,
    required String password,
    required String vehicleType,
    required String vehicleNumber,
    required String city,
    required List<WorkingHourModel> workingHours,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.createDriver,
        {
          "fullname": fullname,
          "phone": phone,
          "password": password,
          "vehicle_type": vehicleType,
          "vehicle_number": vehicleNumber,
          "city": city,
          "working_hours": workingHours.map((e) => e.toJson()).toList(),
        },
      );

      print(response);
      print(response.runtimeType);
      return DriverResponseModel.fromJson(response);

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //reset password
  @override
  Future<String> resetDriverPassword({
    required int id,
    required String newPassword,
  }) async {
    try {
      final response = await apiService.post(
        EndPoints.resetDriverOrRestaurantPassword(id),
        {
          "new_password": newPassword,
        },
      );

      return response['message'];

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //get all drivers
  @override
  Future<List<DriverItemModel>> getAllDrivers() async {
    try {
      final response = await apiService.get(EndPoints.getAllDrivers);
      final List data = response['data'];
      return data.map((e) => DriverItemModel.fromJson(e)).toList();

    }on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //get drivers by city
  @override
  Future<List<DriverByCityModel>> getDriversByCity(String city) async {
    try {
      final response = await apiService.get(
        "${EndPoints.getDriversByCity}/$city",
      );

      final result = DriverByCityResponse.fromJson(response);

      return result.data;

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //get all active drivers
  @override
  Future<List<DriverByCityModel>> getAllActiveDrivers() async {
    try {
      final response = await apiService.get(
        EndPoints.getAllDriversActive,
      );

      final result = DriverByCityResponse.fromJson(response);

      return result.data;

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //get drivers actives in city
  @override
  Future<List<DriverByCityModel>> getActiveDriversByCity(String city) async {
    try {
      final encodedCity = Uri.encodeComponent(city);

      final response = await apiService.get(
        "${EndPoints.getActiveDriversByCity}/$encodedCity",
      );

      final result = DriverByCityResponse.fromJson(response);

      return result.data;

    } on DioException catch (e) {
      throw ApiExceptions.handleError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  //get drivers in turn
  /*@override
  Future<TurnModel> getCurrentDriverTurn({
    required String city,
    required String name,
  }) async {
    try {
      final encodedCity = Uri.encodeComponent(city);

      final response = await apiService.get(
        "${EndPoints.getCurrentDriverTurn}/$encodedCity",

      );

      final result = TurnModel.fromJson(response);

      return result.data;

    } catch (e) {
      rethrow;
    }
  }*/
}