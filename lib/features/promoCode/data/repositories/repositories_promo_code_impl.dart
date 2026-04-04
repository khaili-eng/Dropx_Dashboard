import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

class RepositoriesPromoCodeImpl extends PromoCodeRepositories {
  final RemoteDataSorces remoteDataSorces;

  RepositoriesPromoCodeImpl({required this.remoteDataSorces});
  @override
  Future<Either<ServerException, Unit>> addPromoCode(PromoCodeEntitiy promoCode) {
    // TODO: implement addPromoCode
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, Unit>> deletePromoCode(int id) {
    // TODO: implement deletePromoCode
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, List<PromoCodeEntitiy>>> getPromoCode() {
    // TODO: implement getPromoCode
    throw UnimplementedError();
  }

  @override
  Future<Either<ServerException, Unit>> updatePromoCode(PromoCodeEntitiy promoCode) {
    // TODO: implement updatePromoCode
    throw UnimplementedError();
  }
}