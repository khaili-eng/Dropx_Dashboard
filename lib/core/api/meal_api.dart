import 'dart:io';
import 'package:dio/dio.dart';

class MealApi {
  final Dio dio;
  final String baseUrl;
  final String token;

  MealApi({required this.baseUrl, required this.token})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

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
      "/api/admin/meal/AddMeal/$restaurantId",
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
      "_method": "Post",
    });

    return await dio.post(
      "/api/admin/meal/updateMeal/$mealId",
      data: formData,
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }

  Future<Response> deleteMeal({
    required String token,
    required int mealId,
  }) async {
    return await dio.delete(
      "/api/admin/meal/deleteMeal/$mealId",
      options: Options(headers: {"Authorization": "Bearer $token"}),
    );
  }
}
