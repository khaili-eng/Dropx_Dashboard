import 'package:equatable/equatable.dart';

class PromoCodeEntitiy extends Equatable {
  final int id;
  final String code;
  final String discountType;
  final double discountValue;
  final double minOrderValue;
  final int maxUses;
  final DateTime expiryDate;
  PromoCodeEntitiy({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.minOrderValue,
    required this.maxUses,
    required this.expiryDate,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        code,
        discountType,
        discountValue,
        minOrderValue,
        maxUses,
        expiryDate,
      ];
}


