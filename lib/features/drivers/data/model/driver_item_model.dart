import '../../../auth/data/model/user_mpdel.dart';
import 'driver_model.dart';

class DriverItemModel {
  final DriverModel driver;
  final UserModel user;

  DriverItemModel({
    required this.driver,
    required this.user,
  });

  factory DriverItemModel.fromJson(Map<String, dynamic> json) {
    return DriverItemModel(
      driver: DriverModel.fromJson(json['driver']),
      user: UserModel.fromJson(json['user']),
    );
  }
}