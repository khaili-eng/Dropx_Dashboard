import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/states/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final RestaurantApi apiService;
  OrderCubit(this.apiService) : super(OrderInitial());

  Future<void> getDeliveredOrdersByDay(
    int restaurantId,
    int year,
    int month,
    int day,
  ) async {}
  Future<void> getDeliveredOrdersByMonth(
    int restaurantId,
    int year,
    int month,
  ) async {}
  Future<void> getRestaurantOrdersByStatus(
    int restaurantId,
    String status,
  ) async {}
}
