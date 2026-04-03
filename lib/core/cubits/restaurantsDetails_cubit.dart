import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/states/restaurntDetails_state.dart';

class RestaurantDetailsCubit extends Cubit<RestaurantDetailsState> {
  final RestaurantApi apiService;

  RestaurantDetailsCubit(this.apiService) : super(RestaurantDetailsInitial());

  Future<void> getDetails(int restaurantId) async {
    emit(RestaurantDetailsLoading());
    try {
      final response = await apiService.getRestaurantDetailsWithMeals(
        restaurantId,
      );
      if (response.statusCode == 200) {
        emit(RestaurantDetailsLoaded(response.data));
      } else {
        emit(RestaurantDetailsError("Failed to load restaurant details"));
      }
    } catch (e) {
      emit(RestaurantDetailsError(_handleError(e)));
    }
  }

  Future<void> updateInfo({
    required int id,
    required String fullname,
    required String phone,
    required String description,
    required dynamic imageFile,
    required String city,
    required String commissionType,
    required String commissionValue,
  }) async {
    emit(RestaurantDetailsLoading());
    try {
      final response = await apiService.updateRestaurant(
        id: id,
        fullname: fullname,
        phone: phone,
        description: description,
        imageFile: imageFile,
        city: city,
        commissionType: "fixed",
        commissionValue: "1500",
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(RestaurantUpdateSuccess("Update successful"));
        getDetails(id);
      }
    } catch (e) {
      emit(RestaurantDetailsError(_handleError(e)));
    }
  }

  Future<void> resetPassword(int id, String newPassword) async {
    try {
      final response = await apiService.resetRestaurantPassword(
        id: id,
        newPassword: newPassword,
      );
      if (response.statusCode == 200) {
        emit(RestaurantPasswordResetSuccess());
      }
    } catch (e) {
      emit(RestaurantDetailsError(_handleError(e)));
    }
  }

  String _handleError(dynamic e) {
    if (e is DioException) {
      return e.response?.data['message'] ?? "An unexpected error occurred";
    }
    return "An unexpected error occurred: ${e.toString()}";
  }
}
