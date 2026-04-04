import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

class GetPromoCodeUseCase {
  final PromoCodeRepositories repository;
  GetPromoCodeUseCase(this.repository);

  Future<Either<ServerException, List<PromoCodeEntitiy>>> call() async {
    return await repository.getPromoCode();
  }
}
