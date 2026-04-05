import 'dart:io';
import 'package:dio/dio.dart';

class MealApi {
  final Dio dio;

  MealApi(this.dio) {
    dio.options.baseUrl = "http://127.0.0.1:8000/api";
    dio.options.headers = {"Accept": "application/json"};
  }

  Future<Response> addMeal({
    required String token,
    required int restaurantId,
    required Map<String, dynamic> data,
    required List<File> images,
  }) async {
    FormData formData = FormData.fromMap({
      ...data,
      "images[]":
          images.map((e) {
            return MultipartFile.fromFileSync(e.path);
          }).toList(),
    });

    return await dio.post(
      "/admin/meal/AddMeal/$restaurantId",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> updateMeal({
    required String token,
    required int mealId,
    required Map<String, dynamic> data,
    List<File>? images,
  }) async {
    FormData formData = FormData.fromMap({
      ...data,
      if (images != null)
        "images[]":
            images.map((e) {
              return MultipartFile.fromFileSync(e.path);
            }).toList(),
      "_method": "PUT",
    });

    return await dio.post(
      "/admin/meal/updateMeal/$mealId",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> deleteMeal({
    required String token,
    required int mealId,
  }) async {
    return await dio.delete(
      "/admin/meal/deleteMeal/$mealId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
