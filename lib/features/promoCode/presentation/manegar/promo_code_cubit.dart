import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/promoCode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_status.dart';

class PromoCodeCubit extends Cubit<PromoCodeStatus> {
  final RemoteDataSorcesImpl remoteDataSorcesImpl;
  PromoCodeCubit(this.remoteDataSorcesImpl) : super(PromoCodeInitial());

  Future<void> getPromoCodes() async {
    emit(PromoCodeLoading());
    try {
      final promoCodes = await remoteDataSorcesImpl.getPromoCodes();
      emit(PromoCodeLodded(promoCode: promoCodes));
    } catch (e) {
      emit(PromoCodeError(error: e.toString()));
    }
  }

  Future<void> addPromoCode(PromoCodeModel promoCode) async {
    emit(PromoCodeLoading());
    try {
      await remoteDataSorcesImpl.addPromoCode(promoCode);
      emit(const PromoCodeAdded(message: "Promo code added successfully"));
    } catch (e) {
      emit(PromoCodeError(error: e.toString()));
    }
  }

  Future<void> deletePromoCode(int id) async {
    emit(PromoCodeLoading());
    try {
      await remoteDataSorcesImpl.deletePromoCode(id);
      emit(const PromoCodeDeleted(message: "Promo code deleted successfully"));
    } catch (e) {
      emit(PromoCodeError(error: e.toString()));
    }
  }

  Future<void> updatePromoCode(PromoCodeModel promoCode) async {
    emit(PromoCodeLoading());
    try {
      await remoteDataSorcesImpl.updatePromoCode(promoCode);
      emit(const PromoCodeUpdated(message: "Promo code updated successfully"));
    } catch (e) {
      emit(PromoCodeError(error: e.toString()));
    }
  }
}
