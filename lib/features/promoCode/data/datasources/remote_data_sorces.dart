import 'package:dartz/dartz.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';

abstract class RemoteDataSorces {
  Future<List<PromoCodeModel>> getPromoCodes();
  Future<Unit> addPromoCode(PromoCodeModel promoCode);
  Future<Unit> deletePromoCode(int id);
  Future<Unit> updatePromoCode(PromoCodeModel promoCode);
}


class RemoteDataSorcesImpl implements RemoteDataSorces {
  @override
  Future<Unit> addPromoCode(PromoCodeModel promoCode) {
    // TODO: implement addPromoCode
    throw UnimplementedError();
  }

  @override
  Future<Unit> deletePromoCode(int id) {
    // TODO: implement deletePromoCode
    throw UnimplementedError();
  }

  @override
  Future<List<PromoCodeModel>> getPromoCodes() {
    // TODO: implement getPromoCodes
    throw UnimplementedError();
  }

  @override
  Future<Unit> updatePromoCode(PromoCodeModel promoCode) {
    // TODO: implement updatePromoCode
    throw UnimplementedError();
  }
}
  