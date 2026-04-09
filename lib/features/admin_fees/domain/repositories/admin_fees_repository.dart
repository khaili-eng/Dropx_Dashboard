import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/restaurant_earning_entity.dart';

abstract class AdminFeesRepository {
  Future<Either<ServerException, List<DriverFeeEntity>>>
  getadminMonthlyfeesfromdriver(int year, int month);

  Future<Either<ServerException, List<DriverFeeEntity>>> getadminDailyfeesfromdriver(
    int year,
    int month,
    int day,
  );
  Future<Either<ServerException, List<RestaurantEarningEntity>>>
  getAdminDailyEarningsFromRestaurants(int year);
  Future<Either<ServerException, List<RestaurantEarningEntity>>>
  getAdminMonthlyEarningsFromRestaurants(int year, int month);
}
