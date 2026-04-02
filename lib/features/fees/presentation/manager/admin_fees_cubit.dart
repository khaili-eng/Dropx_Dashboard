import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/admin_fees_api.dart';
import 'package:maadati/features/fees/presentation/manager/admin_fees_status.dart';

class AdminFeesCubit extends Cubit<AdminFeesStatus> {
  AdminFeesCubit() : super(AdminFeesInitial());

  Future<void> fetchMonthlyFees(String year, String month) async {
    emit(AdminFeesLoading());
    try {
      final adminFeeData = await AdminFeesApi().getMonthlyFeesFromDrivers(year, month);
      emit(AdminFeesSuccess(adminFeeData));
    } catch (e) {
      emit(AdminFeesError(e.toString()));
    }
  }
}
