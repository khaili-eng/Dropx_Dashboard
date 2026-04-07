import 'package:maadati/features/promoCode/domain/entities/promo_code_entitiy.dart';

import '../../domain/entities/promo_code_entitiy.dart';

class PromoCodeResponse {
  final bool status;
  final List<PromoCode> data;

  PromoCodeResponse({
    required this.status,
    required this.data,
  });

  factory PromoCodeResponse.fromJson(Map<String, dynamic> json) {
    return PromoCodeResponse(
      status: json['status'] ?? false,
      data: (json['data'] as List<dynamic>? ?? [])
          .map((e) => PromoCode.fromJson(e))
          .toList(),
    );
  }
}