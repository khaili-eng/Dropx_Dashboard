import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/entities/restaurant_earning_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

class FeeRepositoryImpl extends AdminFeesRepository {
  final AdminFeesRemoteDataSource remoteDataSource;

  FeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerException, List<RestaurantEarningEntity>>>
  getAdminDailyEarningsFromRestaurants(int year) async {
    try {
      final remoteData = await remoteDataSource
          .getAdminDailyEarningsFromRestaurants(year);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<RestaurantEarningEntity>>>
  getAdminMonthlyEarningsFromRestaurants(int year, int month) async {
    try {
      final remoteData = await remoteDataSource
          .getAdminMonthlyEarningsFromRestaurants(year, month);
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<DriverFeeEntity>>>
  getadminDailyfeesfromdriver(int year, int month, int day) async {
    try {
      final remoteData = await remoteDataSource.getadminDailyfeesfromdriver(
        year,
        month,
        day,
      );
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<DriverFeeEntity>>>
  getadminMonthlyfeesfromdriver(int year, int month) async {
    try {
      final remoteData = await remoteDataSource.getadminMonthlyfeesfromdriver(
        year,
        month,
      );
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }
}
