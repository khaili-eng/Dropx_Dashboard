class CommissionModel {
  final int id;
  final String restaurantId;
  final String type;
  final int value;

  CommissionModel({
    required this.id,
    required this.restaurantId,
    required this.type,
    required this.value,
  });

  factory CommissionModel.fromJson(Map<String, dynamic> json) {
    return CommissionModel(
      // نستخدم .toString() للأمان لأن السيرفر أحياناً يرسل الرقم كنص
      id: json['id'] is int ? json['id'] : int.parse(json['id'].toString()),
      restaurantId: json['restaurant_id'].toString(),
      type: json['type'] ?? '',
      value:
          json['value'] is int
              ? json['value']
              : int.parse(json['value'].toString()),
    );
  }
}
