import 'package:dio/dio.dart';
import 'package:maadati/features/fees/data/model/admin_fee.dart';

class AdminFeesApi {
  final Dio _dio = Dio();
  final String baseUrl = "http://127.0.0.1:8000/api";

  Future<AdminFee> getMonthlyFeesFromDrivers(String year, String month) async {
    try {
      String myToken = "2|Z0qsMsh3cSKEfHii1MdThgU0yhhiZk9FWqJX9pi0eb6180c0";

      final response = await _dio.get(
        "$baseUrl/admin/fee/getAdminMonthlyEarningsFromRestaurants/$year/$month",
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer $myToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return AdminFee.fromJson(data[0]);
      } else {
        throw Exception("خطأ من السيرفر");
      }
    } on DioException catch (e) {
      String errorMessage = (e.toString());
      throw Exception(errorMessage);
    }
  }
}
