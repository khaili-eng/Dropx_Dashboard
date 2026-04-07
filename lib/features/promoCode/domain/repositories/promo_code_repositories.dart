import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';

import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

abstract class PromoCodeRepositories {
  Future<Either<ServerException, List<PromoCode>>> getPromoCode();
  Future<Either<ServerException, Unit>> addPromoCode(PromoCode promoCode);
  Future<Either<ServerException, Unit>> deletePromoCode(int id);
  Future<Either<ServerException, Unit>> updatePromoCode(PromoCode promoCode);
}
