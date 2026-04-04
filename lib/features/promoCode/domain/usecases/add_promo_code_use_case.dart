import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

class AddPromoCodeUseCase {
  final PromoCodeRepositories repository;
  AddPromoCodeUseCase(this.repository);


  Future<Either<ServerException, Unit>> call(PromoCodeEntitiy promoCode) async {
    return await repository.addPromoCode(promoCode);
  }
}