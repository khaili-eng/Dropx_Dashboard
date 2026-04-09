import 'package:equatable/equatable.dart';

class DriverFeeEntity extends Equatable {
  final int id;
  final String driverName;
  final double amount;
  final String date;
  final String status;
  const DriverFeeEntity({
    required this.id,
    required this.driverName,
    required this.status,
    required this.date,
    required this.amount,
  });

  @override
  List<Object?> get props => [id, driverName, amount, date, status];
}
