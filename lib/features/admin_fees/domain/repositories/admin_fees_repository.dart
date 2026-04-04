import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';

// abstract class FeeRepository {
//   Future<FeeEntity> getFees({
//     required String type,
//     required String period,
//     required int year,
//     int? month,
//     int? day,
//   });
// }

abstract class AdminFeesRepository {
  Future<Either<ServerException , List<FeeEntity>>> getadminMonthlyfeesfromdriver();
  Future<Either<ServerException , List<FeeEntity>>> getadminDailyfeesfromdriver();
  Future<Either<ServerException , List<FeeEntity>>>getAdminDailyEarningsFromRestaurants();
  Future<Either<ServerException , List<FeeEntity>>> getAdminMonthlyEarningsFromRestaurants();
}
