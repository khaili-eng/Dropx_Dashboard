class Order {
  int? id;
  int? userId;
  int? restaurantId;
  int? driverId;
  String? status;
  String? totalPrice;
  DateTime? createdAt;

  Order({
    this.id,
    this.userId,
    this.restaurantId,
    this.driverId,
    this.status,
    this.totalPrice,
    this.createdAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      // استخدام .toInt() أو تحويل آمن للتأكد من النوع
      id: json["id"] is int ? json["id"] : int.tryParse(json["id"].toString()),
      userId:
          json["user_id"] is int
              ? json["user_id"]
              : int.tryParse(json["user_id"].toString()),
      restaurantId:
          json["restaurant_id"] is int
              ? json["restaurant_id"]
              : int.tryParse(json["restaurant_id"].toString()),
      driverId:
          json["driver_id"] is int
              ? json["driver_id"]
              : int.tryParse(json["driver_id"].toString()),
      status: json["status"]?.toString(),
      // تحويل السعر دائماً لنص لضمان عدم حدوث Type Mismatch
      totalPrice: json["total_price"]?.toString(),

      createdAt:
          json["created_at"] == null
              ? null
              : DateTime.tryParse(
                json["created_at"].toString(),
              ), // استخدام tryParse أضمن من parse
    );
  }
}
