import 'package:dio/dio.dart';
import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';
import '../../../../core/error/exceptions.dart';

class FeeRemoteDataSource {
  final Dio dio;

  FeeRemoteDataSource(this.dio);

  Future<FeeModel> getFees({
    required String type,
    required String period,
    required int year,
    int? month,
    int? day,
  }) async {
    try {
      String url;

      if (type == 'driver' && period == 'monthly') {
        url = '/admin/fee/getadminMonthlyfeesfromdriver/$year/$month';
      } else if (type == 'driver') {
        url = '/admin/fee/getadminDailyfeesfromdriver/$year/$month/$day';
      } else if (type == 'restaurant' && period == 'monthly') {
        url =
            '/admin/fee/getAdminMonthlyEarningsFromRestaurants/$year/$month';
      } else {
        url =
            '/admin/fee/getAdminDailyEarningsFromRestaurants/$year/$month/$day';
      }

      final response = await dio.get(url);

      return FeeModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.response?.data['message'] ?? 'Server Error');
    }
  }
}