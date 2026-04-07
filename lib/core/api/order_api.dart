import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/features/order/data/model/order_model.dart';

class ApiService {
  final Dio _dio = Dio();

  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<Order>> fetchAllOrders() async {
    String myToken = ApiConstants.myToken;

    try {
      final response = await _dio.get(
        "$baseUrl/admin/AllOrders",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw Exception("خطأ من السيرفر: ${e.response?.statusCode}");
    }
  }
}
