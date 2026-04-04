import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

class PromoCodeModel extends PromoCodeEntitiy {
  PromoCodeModel({required super.id, required super.code, required super.discountType, required super.discountValue, required super.minOrderValue, required super.maxUses, required super.expiryDate});



  factory PromoCodeModel.fromJson(Map<String, dynamic> json) {
    return PromoCodeModel(
      id: json['id'],
      code: json['code'],
      discountType: json['discountType'],
      discountValue: json['discountValue'].toDouble(),
      minOrderValue: json['minOrderValue'].toDouble(),
      maxUses: json['maxUses'],
      expiryDate: DateTime.parse(json['expiryDate']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'discountType': discountType,
      'discountValue': discountValue,
      'minOrderValue': minOrderValue,
      'maxUses': maxUses,
      'expiryDate': expiryDate.toIso8601String(),
    };
  }
}