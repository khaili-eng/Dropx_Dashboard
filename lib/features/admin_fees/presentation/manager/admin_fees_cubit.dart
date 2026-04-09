import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_earnings_from_restaurants.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_fees_from_driver.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_monthly_earnings_from_restaurants_use_case.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_monthly_feesfrom_driver_use_case.dart';

class AdminFeesCubit extends Cubit<AdminFeesState> {
  final GetAdminMonthlyFeesfromDriverUseCase getMonthlyFeesFromDriver;
  final GetAdminDailyFeesFromDriver getDailyFeesFromDriver;
  final GetAdminDailyEarningsFromRestaurants getDailyEarningsFromRestaurants;
  final GetAdminMonthlyEarningsFromRestaurantsUseCase
  getMonthlyEarningsFromRestaurants;

  AdminFeesCubit({
    required this.getMonthlyFeesFromDriver,
    required this.getDailyFeesFromDriver,
    required this.getDailyEarningsFromRestaurants,
    required this.getMonthlyEarningsFromRestaurants,
  }) : super(DriverFeesInitial());

  Future<void> fetchMonthlyDriverFees(int year, int month) async {
    emit(DriverFeesLoading());
    final result = await getMonthlyFeesFromDriver(year, month);

    result.fold(
      (failure) => emit(AdminFeesError('Failed to load monthly driver fees')),
      (fees) => emit(DriverFeesLoaded(fees)),
    );
  }

  Future<void> fetchDailyDriverFees(int year, int month, int day) async {
    emit(DriverFeesLoading());
    final result = await getDailyFeesFromDriver(year, month, day);

    result.fold(
      (failure) => emit(AdminFeesError('Failed to load daily driver fees')),
      (fees) => emit(DriverFeesLoaded(fees)),
    );
  }

  Future<void> fetchDailyRestaurantEarnings(int year) async {
    emit(RestaurantEarningsLoading());
    final result = await getDailyEarningsFromRestaurants(year);

    result.fold(
      (failure) =>
          emit(AdminFeesError('Failed to load daily restaurant earnings')),
      (earnings) => emit(RestaurantEarningsLoaded(earnings)),
    );
  }

  Future<void> fetchMonthlyRestaurantEarnings(int year, int month) async {
    emit(RestaurantEarningsLoading());
    final result = await getMonthlyEarningsFromRestaurants(year, month);

    result.fold(
      (failure) =>
          emit(AdminFeesError('Failed to load monthly restaurant earnings')),
      (earnings) => emit(RestaurantEarningsLoaded(earnings)),
    );
  }
}
