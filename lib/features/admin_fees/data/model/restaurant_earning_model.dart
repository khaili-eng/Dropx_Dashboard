import 'package:maadati/features/admin_fees/domain/entities/restaurant_earning_entity.dart';

class RestaurantEarningModel extends RestaurantEarningEntity {
  RestaurantEarningModel({
    required super.id,
    required super.restaurantName,
    required super.totalEarnings,
    required super.adminFees,
    required super.date,
  });
  factory RestaurantEarningModel.fromJson(Map<String, dynamic> json) {
    return RestaurantEarningModel(
      id: json['id'] ?? 0,
      restaurantName: json['restaurant_name'] ?? '',
      totalEarnings: (json['total_earnings'] ?? 0).toDouble(),
      adminFees: (json['admin_fees'] ?? 0).toDouble(),
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'restaurant_name': restaurantName,
      'total_earnings': totalEarnings,
      'admin_fees': adminFees,
      'date': date,
    };
  }
}
