

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_earnings_from_restaurants.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_status.dart';

class AdminFeesCubit extends Cubit<AdminFeesState> {
  final  usecase;

  AdminFeesCubit(this.usecase) : super(AdminFeesState());

  Future<void> loadAll(DateTime date) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final driverMonthly = await usecase(
        type: 'driver',
        period: 'monthly',
        year: date.year,
        month: date.month,
      );

      final driverDaily = await usecase(
        type: 'driver',
        period: 'daily',
        year: date.year,
        month: date.month,
        day: date.day,
      );

      final restaurantMonthly = await usecase(
        type: 'restaurant',
        period: 'monthly',
        year: date.year,
        month: date.month,
      );

      final restaurantDaily = await usecase(
        type: 'restaurant',
        period: 'daily',
        year: date.year,
        month: date.month,
        day: date.day,
      );

      emit(state.copyWith(
        loading: false,
        driverMonthly: driverMonthly.total,
        driverDaily: driverDaily.total,
        restaurantMonthly: restaurantMonthly.total,
        restaurantDaily: restaurantDaily.total,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: e.toString(),
      ));
    }
  }
}