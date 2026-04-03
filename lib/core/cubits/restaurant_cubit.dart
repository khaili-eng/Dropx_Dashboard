import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/restaurant_api.dart';
import 'package:maadati/core/states/restaurant_state.dart';

class RestaurantCubit extends Cubit<RestaurantState> {
  final RestaurantApi apiService;
  List<dynamic> allRestaurants = [];
  RestaurantCubit(this.apiService) : super(RestaurantInitial());

  Future<void> getAllRestaurants() async {
    emit(RestaurantLoading());
    try {
      final response = await apiService.getAllRestaurants();
      final List<dynamic> restaurants = response.data['data'] ?? [];
      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError("Faild to load Restaurants: ${e.toString()}"));
    }
  }

  Future<void> getRestaurantsByCity(String city) async {
    emit(RestaurantLoading());
    try {
      final response = await apiService.getRestaurantsByCity(city);

      final List<dynamic> restaurants = response.data['data'] ?? [];

      //final List<dynamic> restaurants = rawData.toList();

      emit(RestaurantLoaded(restaurants));
    } catch (e) {
      emit(RestaurantError("Faild to load the restaurants in this city"));
    }
  }

  Future<void> getRestaurantDetailsWithMeals(int id) async {
    emit(RestaurantLoading());
    try {
      final response = await apiService.getRestaurantDetailsWithMeals(id);

      emit(RestaurantLoaded([response.data['data']]));
    } catch (e) {
      emit(
        RestaurantError("Failed to load Restaurant details: ${e.toString()}"),
      );
    }
  }

  Future<void> storeRestaurant({
    required String fullname,
    required String phone,
    required String password,
    required String city,
    required String description,
    required String workingHoursStart,
    required String workingHoursEnd,
    required String commissionType,
    required String commissionValue,
    required dynamic images,
  }) async {
    emit(RestaurantLoading());
    try {
      await apiService.storeRestaurant(
        fullname: fullname,
        phone: phone,
        password: password,
        city: city,
        description: description,
        workingHoursStart: workingHoursStart,
        workingHoursEnd: workingHoursEnd,
        commissionType: commissionType,
        commissionValue: commissionValue,
        imageFile: images is List ? images.first : images,
      );
      await getAllRestaurants();
    } catch (e) {
      emit(RestaurantError("Failed to create Restaurant: ${e.toString()}"));
    }
  }

  Future<void> updateRestaurant({
    required int id,
    required String fullname,
    required String phone,
    required String city,
    required String description,
    required String commissionType,
    required String commissionValue,
    required dynamic images,
  }) async {
    emit(RestaurantLoading());
    try {
      await apiService.updateRestaurant(
        id: id,
        fullname: fullname,
        phone: phone,
        city: city,
        description: description,
        commissionType: commissionType,
        commissionValue: commissionValue,
        imageFile: images is List ? images.first : images,
      );
      await getAllRestaurants();
    } catch (e) {
      emit(RestaurantError("Failed to update Restaurant: ${e.toString()}"));
    }
  }

  Future<void> resetRestaurantPassword(int id, String newPassword) async {
    try {
      await apiService.resetRestaurantPassword(
        id: id,
        newPassword: newPassword,
      );
    } catch (e) {
      emit(
        RestaurantError("Failed to reset Restaurant password: ${e.toString()}"),
      );
    }
  }

  Future<void> getReports({
    required int restaurantId,
    required int year,
    required int month,
  }) async {
    emit(RestaurantLoading());
    try {
      // ignore: unused_local_variable
      final response = await apiService.getRestaurantMonthlyReport(
        restaurantId: restaurantId,
        year: year,
        month: month,
      );
    } catch (e) {
      emit(RestaurantError("Failed to load report: ${e.toString()}"));
    }
  }
}
