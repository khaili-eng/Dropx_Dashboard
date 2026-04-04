import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/admin_fees/data/datasources/admin_fees_remote_data_source.dart';
import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';
import 'package:maadati/features/admin_fees/domain/repositories/admin_fees_repository.dart';



class FeeRepositoryImpl  extends AdminFeesRepository{
  final AdminFeesRemoteDataSource remoteDataSource;

  FeeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<ServerException, List<FeeEntity>>> getAdminDailyEarningsFromRestaurants() {
    // TODO: implement getAdminDailyEarningsFromRestaurants
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>> getAdminMonthlyEarningsFromRestaurants() {
    // TODO: implement getAdminMonthlyEarningsFromRestaurants
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>> getadminDailyfeesfromdriver() {
    // TODO: implement getadminDailyfeesfromdriver
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, List<FeeEntity>>> getadminMonthlyfeesfromdriver() {
    // TODO: implement getadminMonthlyfeesfromdriver
    throw UnimplementedError();
  }


}