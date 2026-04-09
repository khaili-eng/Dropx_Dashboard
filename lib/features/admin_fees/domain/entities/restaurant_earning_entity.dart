import 'package:equatable/equatable.dart';

class RestaurantEarningEntity extends Equatable {
  final int id;
  final String restaurantName;
  final double totalEarnings;
  final double adminFees;
  final String date;

  RestaurantEarningEntity({
    required this.id,
    required this.restaurantName,
    required this.totalEarnings,
    required this.adminFees,
    required this.date,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [
    id,
    restaurantName,
    totalEarnings,
    adminFees,
    date,
  ];
}
