import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/order_det_api.dart';
import 'package:maadati/features/order_det/presentation/cubit/order_det_state.dart';

class OrderDetCubit extends Cubit<OrderDetState> {
  final ApiServiceDet api;

  OrderDetCubit(this.api) : super(OrderDetInitial());

  Future<void> getOrderDetails(int id) async {
    emit(OrderDetLoading());
    try {
      final data = await api.getOrderDetails(id);
      emit(OrderDetSuccess(data.first));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
