import 'package:bloc/bloc.dart';
import 'package:maadati/core/api/order_api.dart';
import 'package:maadati/features/order/presentation/cubit/oder_stata.dart';

class OrderCubit extends Cubit<OrderState> {
  final ApiService apiService;

  OrderCubit(this.apiService) : super(OrderInitial());

  Future<void> getAllOrders() async {
    emit(OrderLoading());
    try {
      final orders = await apiService.fetchAllOrders();
      emit(OrderSuccess(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
