import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/features/promocode/data/datasources/remote_data_sorces.dart';
import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';
import 'package:maadati/features/promoCode/presentation/manegar/promo_code_status.dart';
import 'package:maadati/features/promocode/presentation/manegar/promo_code_status.dart';

import '../../domain/entities/promo_code_entitiy.dart';

class PromoCubit extends Cubit<PromoState> {
   
  final PromoRemoteDataSource remote;

    PromoCubit(this.remote) : super(PromoInitial()) {
    print("PROMO CUBIT CREATED"); // 🔥
  }
  

  Future<void> getPromo() async {
      print("GET PROMO CALLED 🔥"); 
    emit(PromoLoading());
    try {
      final data = await remote.getAll();
      print("DATA FROM API => $data");
      emit(PromoLoaded(data));
    } catch (e) {
      emit(PromoError(e.toString()));
    }
  }

  Future<void> addPromo(PromoCode promo) async {
    emit(PromoLoading());
    try {
      await remote.add(promo);
      getPromo();
    } catch (e) {
      emit(PromoError(e.toString()));
    }
  }

  Future<void> deletePromo(int id) async {
    emit(PromoLoading());
    try {
      await remote.delete(id);
      getPromo();
    } catch (e) {
      emit(PromoError(e.toString()));
    }
  }

  Future<void> updatePromo(PromoCode promo) async {
    emit(PromoLoading());
    try {
      await remote.update(promo);
      getPromo();
    } catch (e) {
      emit(PromoError(e.toString()));
    }
  }
}
