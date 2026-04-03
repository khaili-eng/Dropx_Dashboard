import '../../../auth/data/model/user_mpdel.dart';
import 'driver_model.dart';

class DriverResponseModel {
  final String message;
  final UserModel user;
  final DriverModel driver;

  DriverResponseModel({
    required this.message,
    required this.user,
    required this.driver,
  });

  factory DriverResponseModel.fromJson(Map<String, dynamic> json) {
    return DriverResponseModel(
      message: json['message'],
      user: UserModel.fromJson(json['user']),
      driver: DriverModel.fromJson(json['driver']),
    );
  }
}