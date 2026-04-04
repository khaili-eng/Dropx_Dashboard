import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';



class FeeRepositoryImpl implements FeeRepository {
  final FeeRemoteDataSource remote;

  FeeRepositoryImpl(this.remote);

  @override
  Future<FeeEntity> getFees({
    required String type,
    required String period,
    required int year,
    int? month,
    int? day,
  }) {
    return remote.getFees(
      type: type,
      period: period,
      year: year,
      month: month,
      day: day,
    );
  }
}