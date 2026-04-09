

import 'package:equatable/equatable.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/restaurant_earning_entity.dart';

abstract class AdminFeesState extends Equatable {
  const AdminFeesState();
  @override
  List<Object?> get props => [];
}

// Driver Fees States
class DriverFeesInitial extends AdminFeesState {}
class DriverFeesLoading extends AdminFeesState {}
class DriverFeesLoaded extends AdminFeesState {
  final List<DriverFeeEntity> fees;
  const DriverFeesLoaded(this.fees);
  @override
  List<Object?> get props => [fees];
}

// Restaurant Earnings States
class RestaurantEarningsInitial extends AdminFeesState {}
class RestaurantEarningsLoading extends AdminFeesState {}
class RestaurantEarningsLoaded extends AdminFeesState {
  final List<RestaurantEarningEntity> earnings;
  const RestaurantEarningsLoaded(this.earnings);
  @override
  List<Object?> get props => [earnings];
}

// Error State
class AdminFeesError extends AdminFeesState {
  final String message;
  const AdminFeesError(this.message);
  @override
  List<Object?> get props => [message];
}