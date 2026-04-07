import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/domain/entities/fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';

class FeeRepositoryImpl extends AdminFeesRepository {
  final AdminFeesRemoteDataSource remoteDataSource;

  FeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerException, List<FeeEntity>>>
  getAdminDailyEarningsFromRestaurants() async {
    try {
      final remoteData =
          await remoteDataSource.getAdminDailyEarningsFromRestaurants();
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>>
  getAdminMonthlyEarningsFromRestaurants() async {
    try {
      final remoteData =
          await remoteDataSource.getAdminMonthlyEarningsFromRestaurants();
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>>
  getadminDailyfeesfromdriver() async {
    try {
      final remoteData = await remoteDataSource.getadminDailyfeesfromdriver();
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>>
  getadminMonthlyfeesfromdriver() async {
    try {
      final remoteData = await remoteDataSource.getadminMonthlyfeesfromdriver();
      return Right(remoteData);
    } on ServerException {
      return Left(ServerException("Failed to fetch promo codes"));
    }
  }
}
