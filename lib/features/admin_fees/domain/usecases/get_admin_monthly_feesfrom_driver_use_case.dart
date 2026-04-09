import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';

import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

class GetAdminMonthlyFeesfromDriverUseCase {
  final AdminFeesRepository repository;

  GetAdminMonthlyFeesfromDriverUseCase(this.repository);
  Future<Either<ServerException, List<DriverFeeEntity>>> call(
    int year,
    int month,
  ) async {
    return await repository.getadminMonthlyfeesfromdriver(year, month);
  }
}
