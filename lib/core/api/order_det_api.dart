import 'package:dio/dio.dart';
import 'package:maadati/core/constants/end_point/end_points.dart';


import 'package:maadati/features/order_det/data/model/order_det_model.dart';

class ApiServiceDet {
  final Dio _dio = Dio();

  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<List<OrderData>> getOrderDetails(int id) async {

    String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";
    // String myToken = PrefHelper.getToken() as String;

    try {
      final res = await _dio.get(
        "$baseUrl${EndPoints.OrderDet(id)}",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );


           if (res.statusCode == 200) {
        final order = OrderResponse.fromJson(res.data);
        return [order.data]; 
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      throw Exception("خطأ من السيرفر: ${e.response?.statusCode}");
    }
  }
}
   

