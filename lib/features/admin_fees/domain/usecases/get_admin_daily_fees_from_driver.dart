import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

class GetAdminDailyFeesFromDriver {
  final AdminFeesRepository repository;

  GetAdminDailyFeesFromDriver(this.repository);
  Future<Either<ServerException, List<DriverFeeEntity>>> call(
    int year,
    int month,
    int day,
  ) async {
    return await repository.getadminDailyfeesfromdriver(year, month, day);
  }
}
