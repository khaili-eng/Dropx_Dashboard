import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';

class DriverFeeModel extends DriverFeeEntity {
  DriverFeeModel({
    required super.id,
    required super.driverName,
    required super.status,
    required super.date,
    required super.amount,
  });

  factory DriverFeeModel.fromJson(Map<String, dynamic> json) {
    return DriverFeeModel(
      id: json['id'] ?? 0,
      driverName: json['driver_name'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      date: json['date'] ?? '',
      status: json['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'driver_name': driverName,
      'amount': amount,
      'date': date,
      'status': status,
    };
  }
}
