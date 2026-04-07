import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';

class AdminFeesCubit extends Cubit<AdminFeesStatus> {
  final AdminFeesRemoteDataSource dminFeesRemoteDataSource;

  AdminFeesCubit(this.dminFeesRemoteDataSource) : super(AdminFeesInitial());
  Future<void> getAdminDailyEarningsFromRestaurants() async {
    emit(AdminFeesLoading());
    try {
      final adminFees =
          await dminFeesRemoteDataSource.getAdminDailyEarningsFromRestaurants();
      emit(AdminFeesLodded(adminFees: adminFees));
    } catch (e) {
      emit(AdminFeesError(error: e.toString()));
    }
  }

  Future<void> getAdminMonthlyEarningsFromRestaurants() async {
    emit(AdminFeesLoading());
    try {
      final adminFees =
          await dminFeesRemoteDataSource
              .getAdminMonthlyEarningsFromRestaurants();
      emit(AdminFeesLodded(adminFees: adminFees));
    } catch (e) {
      emit(AdminFeesError(error: e.toString()));
    }
  }

  Future<void> getadminDailyfeesfromdriver() async {
    emit(AdminFeesLoading());
    try {
      final adminFees =
          await dminFeesRemoteDataSource.getadminDailyfeesfromdriver();
      emit(AdminFeesLodded(adminFees: adminFees));
    } catch (e) {
      emit(AdminFeesError(error: e.toString()));
    }
  }

  Future<void> getadminMonthlyfeesfromdriver() async {
    emit(AdminFeesLoading());
    try {
      final adminFees =
          await dminFeesRemoteDataSource.getadminMonthlyfeesfromdriver();
      emit(AdminFeesLodded(adminFees: adminFees));
    } catch (e) {
      emit(AdminFeesError(error: e.toString()));
    }
  }
}
