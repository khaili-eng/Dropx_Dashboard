import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/network/api/api_error.dart';
import '../../data/model/working_hour_model.dart';
import '../../repo/driver_repo.dart';
import 'driver_state.dart';


class DriverCubit extends Cubit<DriverState> {
  final DriverRepo driverRepo;

  DriverCubit(this.driverRepo) : super(DriverInitial());

  Future<void> createDriver({
    required String fullname,
    required String phone,
    required String password,
    required String vehicleType,
    required String vehicleNumber,
    required String city,
    required List<WorkingHourModel> workingHours,
  }) async {
    emit(DriverLoading());

    try {
      final result = await driverRepo.createDriver(
        fullname: fullname,
        phone: phone,
        password: password,
        vehicleType: vehicleType,
        vehicleNumber: vehicleNumber,
        city: city,
        workingHours: workingHours,
      );

      emit(DriverSuccess(result.message));

    } catch (e) {
      emit(DriverError(e.toString()));
    }
  }
  //function for reset password
  Future<void> resetDriverPassword({
    required int id,
    required String newPassword,
  }) async {
    emit(ResetPasswordLoading());

    try {
      final message = await driverRepo.resetDriverPassword(
        id: id,
        newPassword: newPassword,
      );

      emit(ResetPasswordSuccess(message));

    } catch (e) {
      if (e is ApiError && e.isValidationError) {
        emit(DriverValidationError(e));
      } else {
        emit(ResetPasswordError(e.toString()));
      }
    }
  }
  //get all drivers
  Future<void> getAllDrivers() async {
    emit(DriversLoading());

    try {
      final drivers = await driverRepo.getAllDrivers();

      emit(DriversSuccess(drivers));

    } catch (e) {
      emit(DriversError(e.toString()));
    }
  }
  //get drivers by city
  Future<void> getDriversByCity(String city) async {
    emit(DriversByCityLoading());

    try {
      final drivers = await driverRepo.getDriversByCity(city);

      emit(DriversByCitySuccess(drivers));

    } catch (e) {
      emit(DriversByCityError(e.toString()));
    }
  }
  //get all active drivers
  Future<void> getAllActiveDrivers() async {
    emit(AllActiveDriversLoading());

    try {
      final drivers = await driverRepo.getAllActiveDrivers();

      emit(AllActiveDriversSuccess(drivers));

    } catch (e) {
      emit(AllActiveDriversError(e.toString()));
    }
  }
  //get active drivers in city
  Future<void> getActiveDriversByCity(String city) async {
    emit(ActiveDriversLoading());

    try {
      final drivers = await driverRepo.getActiveDriversByCity(city);

      emit(ActiveDriversSuccess(drivers));

    } catch (e) {
      emit(ActiveDriversError(e.toString()));
    }
  }
}