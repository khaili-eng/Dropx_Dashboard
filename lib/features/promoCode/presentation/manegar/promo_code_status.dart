// import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';

import 'package:equatable/equatable.dart';
import 'package:maadati/features/promoCode/data/model/promo_code_model.dart';

abstract class PromoCodeStatus extends Equatable{
  const PromoCodeStatus();
  @override
  List<Object?> get props => [];
}

class PromoCodeInitial extends PromoCodeStatus {

}

class PromoCodeLoading extends PromoCodeStatus {}

class PromoCodeLodded extends PromoCodeStatus {
  final List<PromoCodeModel> promoCode;
 const PromoCodeLodded({required this.promoCode});
   @override
  List<Object?> get props => [promoCode];
}

class PromoCodeError extends PromoCodeStatus {
  final String error;
const  PromoCodeError({required this.error});
@override
  List<Object?> get props => [error];
}



class PromoCodeDeleted extends PromoCodeStatus {
  final String message;
 const PromoCodeDeleted({required this.message});
  @override
  List<Object?> get props => [message];
}


class PromoCodeAdded extends PromoCodeStatus {
  final String message;
 const PromoCodeAdded({required this.message});
  @override
  List<Object?> get props => [message];
}
class PromoCodeUpdated extends PromoCodeStatus {
  final String message;
 const PromoCodeUpdated({required this.message});
  @override
  List<Object?> get props => [message];
}


