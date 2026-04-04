import 'package:maadati/features/admin_fees/domain/entities/driver_fee_entity.dart';

class FeeModel extends FeeEntity {
  FeeModel({required super.status, required super.date, required super.total});

  factory FeeModel.fromJson(Map<String, dynamic> json) {
    return FeeModel(
      status: json['status'] ?? false,
      date: json['date'] ?? '',
      total:
          (json['total_admin_earnings_from_restaurants'] ??
                  json['total_admin_fees_from_drivers'] ??
                  json['total'] ??
                  0)
              .toDouble(),
    );
  }
}
