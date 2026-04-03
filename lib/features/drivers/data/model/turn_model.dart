import 'package:maadati/features/drivers/data/model/driver_model.dart';

class TurnModel {
  final int id;
  final int driverId;
  final int turnOrder;
  final bool isNext;
  final bool isActive;
  final DriverModel driver;

  TurnModel({
    required this.id,
    required this.driverId,
    required this.turnOrder,
    required this.isNext,
    required this.isActive,
    required this.driver,
  });

  factory TurnModel.fromJson(Map<String, dynamic> json) {
    return TurnModel(
      id: json['id'],
      driverId: json['driver_id'],
      turnOrder: json['turn_order'],
      isNext: json['is_next'] == 1,
      isActive: json['is_active'] == 1,
      driver: DriverModel.fromJson(json['driver']),
    );
  }
}