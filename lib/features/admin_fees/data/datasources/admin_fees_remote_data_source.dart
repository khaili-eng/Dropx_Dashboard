import 'package:maadati/features/admin_fees/data/model/admin_fee.dart';

 abstract class AdminFeesRemoteDataSource {

  Future<List<FeeModel>> getadminMonthlyfeesfromdriver();
  Future<List<FeeModel>> getadminDailyfeesfromdriver();
  Future<List<FeeModel>> getAdminDailyEarningsFromRestaurants();
  Future<List<FeeModel>> getAdminMonthlyEarningsFromRestaurants();
}


class AdminFeesRemoteDataSourceImpl implements AdminFeesRemoteDataSource{
  @override
  Future<List<FeeModel>> getAdminDailyEarningsFromRestaurants() {
    // TODO: implement getAdminDailyEarningsFromRestaurants
    throw UnimplementedError();
  }

  @override
  Future<List<FeeModel>> getAdminMonthlyEarningsFromRestaurants() {
    // TODO: implement getAdminMonthlyEarningsFromRestaurants
    throw UnimplementedError();
  }

  @override
  Future<List<FeeModel>> getadminDailyfeesfromdriver() {
    // TODO: implement getadminDailyfeesfromdriver
    throw UnimplementedError();
  }

  @override
  Future<List<FeeModel>> getadminMonthlyfeesfromdriver() {
    // TODO: implement getadminMonthlyfeesfromdriver
    throw UnimplementedError();
  }
}
  