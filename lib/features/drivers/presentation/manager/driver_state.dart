import '../../../../core/network/api/api_error.dart';
import '../../data/model/driver_by_city_response.dart';
import '../../data/model/driver_item_model.dart';
import '../../data/model/driver_list_response.dart';

abstract class DriverState {}

class DriverInitial extends DriverState {}

class DriverLoading extends DriverState {}

class DriverSuccess extends DriverState {
  final String message;

  DriverSuccess(this.message);
}

class DriverError extends DriverState {
  final String error;

  DriverError(this.error);
}
class DriverValidationError extends DriverState {
  final ApiError error;

  DriverValidationError(this.error);
}

//states for reset password
class ResetPasswordLoading extends DriverState {}

class ResetPasswordSuccess extends DriverState {
  final String message;

  ResetPasswordSuccess(this.message);
}

class ResetPasswordError extends DriverState {
  final String error;

  ResetPasswordError(this.error);
}
//states for get drivers
class DriversLoading extends DriverState {}

class DriversSuccess extends DriverState {
  final List<DriverItemModel> drivers;

  DriversSuccess(this.drivers);
}

class DriversError extends DriverState {
  final String error;

  DriversError(this.error);
}
//states for get drivers by city
class DriversByCityLoading extends DriverState {}

class DriversByCitySuccess extends DriverState {
  final List<DriverByCityModel> drivers;

  DriversByCitySuccess(this.drivers);
}

class DriversByCityError extends DriverState {
  final String error;

  DriversByCityError(this.error);
}
//states for get active drivers by city
class ActiveDriversLoading extends DriverState {}

class ActiveDriversSuccess extends DriverState {
  final List<DriverByCityModel> drivers;

  ActiveDriversSuccess(this.drivers);
}

class ActiveDriversError extends DriverState {
  final String error;

  ActiveDriversError(this.error);
}
//states for all active drivers
class AllActiveDriversLoading extends DriverState {}

class AllActiveDriversSuccess extends DriverState {
  final List<DriverByCityModel> drivers;

  AllActiveDriversSuccess(this.drivers);
}

class AllActiveDriversError extends DriverState {
  final String error;

  AllActiveDriversError(this.error);
}