import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/states/order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final RestaurantApi apiService;

  OrderCubit(this.apiService) : super(OrderInitial());

  // 1. جلب الطلبات المسلمة حسب اليوم
  Future<void> getDeliveredOrdersByDay(
    int restaurantId,
    int year,
    int month,
    int day,
  ) async {
    emit(OrderLoading());
    try {
      final response = await apiService.getDeliveredOrdersByDayForRestaurant(
        restaurantId: restaurantId,
        year: year,
        month: month,
        day: day,
      );
      emit(OrderLoaded(response.data));
    } catch (e) {
      emit(OrderError(_handleError(e)));
    }
  }

  // 2. جلب الطلبات المسلمة حسب الشهر
  Future<void> getDeliveredOrdersByMonth(
    int restaurantId,
    int year,
    int month,
  ) async {
    emit(OrderLoading());
    try {
      final response = await apiService.getDeliveredOrdersByMonthForRestaurant(
        restaurantId: restaurantId,
        year: year,
        month: month,
      );
      emit(OrderLoaded(response.data));
    } catch (e) {
      emit(OrderError(_handleError(e)));
    }
  }

  // 3. جلب تقرير يومي للمطعم
  Future<void> getDailyReport(
    int restaurantId,
    int year,
    int month,
    int day,
  ) async {
    emit(OrderLoading());
    try {
      final response = await apiService.getRestaurantDailyReport(
        restaurantId: restaurantId,
        year: year,
        month: month,
        day: day,
      );
      emit(OrderLoaded(response.data));
    } catch (e) {
      emit(OrderError(_handleError(e)));
    }
  }

  // 4. جلب تقرير شهري للمطعم
  Future<void> getMonthlyReport(int restaurantId, int year, int month) async {
    emit(OrderLoading());
    try {
      final response = await apiService.getRestaurantMonthlyReport(
        restaurantId: restaurantId,
        year: year,
        month: month,
      );
      emit(OrderLoaded(response.data));
    } catch (e) {
      emit(OrderError(_handleError(e)));
    }
  }

  // 5. جلب الطلبات حسب الحالة (قيد الانتظار، تم التوصيل، إلخ)
  Future<void> getOrdersByStatus(int restaurantId, String status) async {
    emit(OrderLoading());
    try {
      final response = await apiService.getRestaurantOrdersByStatus(
        restaurantId: restaurantId,
        status: status,
      );
      emit(OrderLoaded(response.data));
    } catch (e) {
      emit(OrderError(_handleError(e)));
    }
  }

  // دالة مساعدة للتعامل مع أخطاء Dio
  String _handleError(dynamic e) {
    if (e is DioException) {
      return e.response?.data['message'] ?? "حدث خطأ في الاتصال بالسيرفر";
    }
    return "حدث خطأ غير متوقع";
  }
}
