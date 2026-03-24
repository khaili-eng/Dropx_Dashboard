import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/commission_api.dart';
import 'package:maadati/core/states/commission_state.dart';
import 'package:maadati/features/models/commissionModel/commission_model.dart';

class CommissionCubit extends Cubit<CommissionState> {
  final CommissionApi api;

  CommissionCubit(this.api) : super(CommissionInitial());

  Future<void> addCommission({
    required int restaurantId,
    required String type,
    required int value,
  }) async {
    emit(CommissionLoading());

    try {
      final response = await api.addCommission(
        restaurantId: restaurantId,
        type: type,
        value: value,
      );

      final commission = CommissionModel.fromJson(response.data);

      emit(CommissionSuccess(commission));
    } catch (e) {
      emit(CommissionError(e.toString()));
    }
  }

  Future<void> updateCommission({
    required int id,
    required String type,
    required int value,
  }) async {
    emit(CommissionLoading());

    try {
      final response = await api.updateCommission(
        id: id,
        type: type,
        value: value,
      );

      final commission = CommissionModel.fromJson(response.data);

      emit(CommissionSuccess(commission));
    } catch (e) {
      emit(CommissionError(e.toString()));
    }
  }
}
