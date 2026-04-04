
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';

abstract class FeeRepository {
  Future<FeeEntity> getFees({
    required String type,
    required String period,
    required int year,
    int? month,
    int? day,
  });
}