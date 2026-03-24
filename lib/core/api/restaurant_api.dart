import 'dart:io';

import 'package:dio/dio.dart';

class RestaurantApi {
  final Dio dio;
  final String baseUrl;
  final String token;

  RestaurantApi({required this.baseUrl, required this.token})
    : dio = Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            "Authorization": "Bearer $token",
            "Accept": "application/json",
          },
        ),
      );

  Future<Response> storeRestaurant({
    required String fullname,
    required String phone,
    required String password,
    required String city,
    required String description,
    required String workingHoursStart,
    required String workingHoursEnd,
    required String commissionType,
    required String commissionValue,
    required List<File> images,
  }) async {
    FormData formData = FormData.fromMap({
      "fullname": fullname,
      "phone": phone,
      "password": password,
      "city": city,
      "description": description,
      "working_hours_start": workingHoursStart,
      "working_hours_end": workingHoursEnd,
      "commission_type": commissionType,
      "commission_value": commissionValue,
      "image": images,
    });

    return dio.post("/api/admin/resturant/storeresturant", data: formData);
  }

  Future<Response> updateRestaurant({
    required int id,
    required String fullname,
    required String phone,
    required String city,
    required String description,
    required String commissionType,
    required String commissionValue,
    required List<File> images,
  }) async {
    Map<String, dynamic> data = {
      "fullname": fullname,
      "phone": phone,
      "city": city,
      "description": description,
      "commission_type": commissionType,
      "commission_value": commissionValue,
    };

    data["image"] = await MultipartFile.fromFile(
      images[0].path,
      filename: images[0].path.split('/').last,
    );

    FormData formData = FormData.fromMap(data);
    return dio.post(
      "/api/admin/resturant/updateRestaurant/$id",
      data: formData,
    );
  }

  Future<Response> resetRestaurantPassword({
    required int id,
    required String newPassword,
  }) async {
    return dio.post(
      "/api/admin/driverandresturant/resetRestaurantPassword/$id",
      data: {"new_password": newPassword},
    );
  }

  Future<Response> getAllRestaurants() async {
    return dio.get("/api/admin/resturant/getAllRestaurants");
  }

  Future<Response> getRestaurantsByCity(String city) async {
    return dio.get("/api/admin/resturant/getRestaurantsByCity/$city");
  }

  Future<Response> getRestaurantDetailsWithMeals(int id) async {
    return dio.get("/api/admin/resturant/getRestaurantDetailsWithMeals/$id");
  }

  Future<Response> getDeliveredOrdersByDayForRestaurant({
    required int restaurantId,
    required int year,
    required int month,
    required int day,
  }) async {
    return dio.get(
      "/api/admin/resturant/getDeliveredOrdersByDayForresturant/$restaurantId/$year/$month/$day",
    );
  }

  Future<Response> getDeliveredOrdersByMonthForRestaurant({
    required int restaurantId,
    required int year,
    required int month,
  }) async {
    return dio.get(
      "/api/admin/resturant/getDeliveredOrdersForRestaurantByMonth/$restaurantId/$year/$month",
    );
  }

  Future<Response> getRestaurantDailyReport({
    required int restaurantId,
    required int year,
    required int month,
    required int day,
  }) async {
    return dio.get(
      "/api/admin/resturant/getRestaurantDailyReport/$restaurantId/$year/$month/$day",
    );
  }

  Future<Response> getRestaurantMonthlyReport({
    required int restaurantId,
    required int year,
    required int month,
  }) async {
    return dio.get(
      "/api/admin/resturant/getRestaurantMonthlyReport/$restaurantId/$year/$month",
    );
  }

  Future<Response> getRestaurantOrdersByStatus({
    required int restaurantId,
    required String status,
  }) async {
    return dio.post(
      "/api/admin/resturant/getRestaurantOrdersByStatus/$restaurantId",
      data: {"status": status},
    );
  }
}
