import 'package:maadati/features/drivers/data/model/driver_response_model.dart';
import 'package:maadati/features/drivers/data/model/working_hour_model.dart';

import '../data/model/driver_by_city_response.dart';
import '../data/model/driver_item_model.dart';
import '../data/model/driver_list_response.dart';
import '../data/model/turn_model.dart';

abstract class DriverRepo{
  Future<DriverResponseModel>createDriver({
    required String fullname,
    required String phone,
    required String password,
    required String vehicleType,
    required String vehicleNumber,
    required String city,
    required List<WorkingHourModel>workingHours,
});
  Future<String> resetDriverPassword({
    required int id,
    required String newPassword,
  });
  Future<List<DriverItemModel>> getAllDrivers();
  Future<List<DriverByCityModel>> getDriversByCity(String city);
  Future<List<DriverByCityModel>> getAllActiveDrivers();
  Future<List<DriverByCityModel>> getActiveDriversByCity(String city);
  //Future<TurnModel> getCurrentDriverTurn({
    //required String city,
    //required String name,
  //});
}