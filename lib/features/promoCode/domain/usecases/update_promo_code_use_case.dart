import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';

import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

class UpdatePromoCodeUseCase {
  final PromoCodeRepositories repository;
  UpdatePromoCodeUseCase(this.repository);

  Future<Either<ServerException, Unit>> call(PromoCode promoCode) async {
    return await repository.updatePromoCode(promoCode);
  }
}
