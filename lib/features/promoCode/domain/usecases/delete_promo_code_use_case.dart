import 'package:dartz/dartz.dart';
import 'package:maadati/core/error/exceptions.dart';
import 'package:maadati/features/promoCode/domain/repositories/promo_code_repositories.dart';

class DeletePromoCodeUseCase {
  final PromoCodeRepositories repository;
  DeletePromoCodeUseCase(this.repository);

  Future<Either<ServerException, Unit>> call(int id) async {
    return await repository.deletePromoCode(id);
  }
}
