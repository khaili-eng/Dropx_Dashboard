import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/api/meal_api.dart';
import 'package:maadati/core/states/meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final MealApi apiService;

  MealCubit(this.apiService) : super(MealInitial());

  Future<void> addMeal({
    required String token,
    required int restaurantId,
    required Map<String, dynamic> data,
    required List<File> images,
  }) async {
    emit(MealLoading());
    try {
      final response = await apiService.addMeal(
        token: token,
        restaurantId: restaurantId,
        data: data,
        images: images,
      );

      emit(MealSuccess(response.data.toString()));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> updateMeal({
    required String token,
    required int mealId,
    required Map<String, dynamic> data,
    List<File>? images,
  }) async {
    emit(MealLoading());
    try {
      final response = await apiService.updateMeal(
        token: token,
        mealId: mealId,
        data: data,
        images: images,
      );

      emit(MealSuccess(response.data.toString()));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> deleteMeal({required String token, required int mealId}) async {
    emit(MealLoading());
    try {
      // ignore: unused_local_variable
      final response = await apiService.deleteMeal(
        token: token,
        mealId: mealId,
      );

      emit(MealSuccess("Deleted successfully"));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}
