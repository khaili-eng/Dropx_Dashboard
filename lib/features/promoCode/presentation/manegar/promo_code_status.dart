import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

abstract class PromoState {}

class PromoInitial extends PromoState {}

class PromoLoading extends PromoState {}

class PromoLoaded extends PromoState {
  final List<PromoCode> data;

  PromoLoaded(this.data);
}

class PromoError extends PromoState {
  final String message;

  PromoError(this.message);
}