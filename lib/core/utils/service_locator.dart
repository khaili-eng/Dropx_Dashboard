import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:maadati/core/api/network/api_constants.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/data/repositories/admin_fees_repository_impl.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_earnings_from_restaurants.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_daily_fees_from_driver.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_monthly_earnings_from_restaurants_use_case.dart';
import 'package:maadati/features/admin_fees/domain/usecases/get_admin_monthly_feesfrom_driver_use_case.dart';
import 'package:maadati/features/admin_fees/presentation/manager/admin_fees_cubit.dart';


final sl = GetIt.instance;

void init() {
  // Dio Client
  sl.registerLazySingleton<Dio>(() => Dio(BaseOptions(
    baseUrl: ApiConstants.baseUrl,  
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
  )));

  // Admin Fees Remote Data Source
  sl.registerLazySingleton<AdminFeesRemoteDataSource>(
    () => AdminFeesRemoteDataSourceImpl(dio: sl()),
  );

  // Admin Fees Repository
  sl.registerLazySingleton<AdminFeesRepository>(
    () => FeeRepositoryImpl(remoteDataSource: sl()),
  );

  // Admin Fees Use Cases
  sl.registerLazySingleton(() => GetAdminDailyEarningsFromRestaurants(sl()));
  sl.registerLazySingleton(() => GetAdminDailyFeesFromDriver(sl()));
  sl.registerLazySingleton(() => GetAdminMonthlyEarningsFromRestaurantsUseCase(sl()));
  sl.registerLazySingleton(() => GetAdminMonthlyFeesfromDriverUseCase(sl()));

  // Admin Fees Cubit
  sl.registerFactory(() => AdminFeesCubit(
    getMonthlyFeesFromDriver: sl(),
    getDailyFeesFromDriver: sl(),
    getDailyEarningsFromRestaurants: sl(),
    getMonthlyEarningsFromRestaurants: sl(),
  ));
}