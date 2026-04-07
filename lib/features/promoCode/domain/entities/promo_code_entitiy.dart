class PromoCode {
  final int id;
  final String code;
  final String discountType;
  final double discountValue;
  final double minOrderValue;
  final int maxUses;
  final DateTime expiryDate;
  final bool isActive;

  PromoCode({
    required this.id,
    required this.code,
    required this.discountType,
    required this.discountValue,
    required this.minOrderValue,
    required this.maxUses,
    required this.expiryDate,
    required this.isActive,
  });

  factory PromoCode.fromJson(Map<String, dynamic> json) {
    return PromoCode(
      id: json['id'] ?? 0,
      code: json['code'] ?? '',
      discountType: json['discount_type'] ?? '',
      discountValue: double.tryParse(json['discount_value'].toString()) ?? 0,
      minOrderValue: double.tryParse(json['min_order_value'].toString()) ?? 0,
      maxUses: json['max_uses'] ?? 0,
      expiryDate: DateTime.tryParse(json['expiry_date'] ?? '') ?? DateTime.now(),
      isActive: json['is_active'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "discount_type": discountType,
      "discount_value": discountValue,
      "min_order_value": minOrderValue,
      "max_uses": maxUses,
      "expiry_date": expiryDate.toIso8601String(),
      "is_active": isActive ? 1 : 0,
    };
  }
}