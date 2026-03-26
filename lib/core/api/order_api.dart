import 'package:dio/dio.dart';
import 'package:maadati/features/order/data/model/order_model.dart';


class ApiService {
  final Dio _dio = Dio();
  
  // استخدم 10.0.2.2 للمحاكي أو IP جهازك إذا كنت تستخدم موبايل حقيقي
  final String baseUrl = "http://10.0.2.2:8000/api";

  Future<List<Order>> fetchAllOrders() async {
    // انسخ التوكن من بوستمان وضعه هنا للتجربة فقط
    String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";

    try {
      final response = await _dio.get(
        "$baseUrl/admin/AllOrders",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken', // إرسال التوكن ضروري جداً
          },
        ),
      );

      if (response.statusCode == 200) {
        // تأكد أن الـ JSON يبدأ بـ {"data": [...]}
        List<dynamic> data = response.data['data']; 
        return data.map((json) => Order.fromJson(json)).toList();
      } else {
        throw Exception("فشل في الوصول للسيرفر");
      }
    } on DioException catch (e) {
      // طباعة الخطأ الحقيقي في الـ Console لمعرفة السبب
      print("Error Data: ${e.response?.data}");
      throw Exception("خطأ من السيرفر: ${e.response?.statusCode}");
    }
  }
}