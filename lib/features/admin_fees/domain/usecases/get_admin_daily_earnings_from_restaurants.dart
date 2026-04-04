// import 'package:maadati/features/admin_fees/domain/entities/restaurant_earning_entity.dart';
// import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

// class GetAdminDailyEarningsFromRestaurants {
//   final AdminFeesRepository repository;


import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

class GetFees {
  final FeeRepository repository;

  GetFees(this.repository);

  Future<FeeEntity> call({
    required String type,
    required String period,
    required int year,
    int? month,
    int? day,
  }) {
    return repository.getFees(
      type: type,
      period: period,
      year: year,
      month: month,
      day: day,
    );
  }
}