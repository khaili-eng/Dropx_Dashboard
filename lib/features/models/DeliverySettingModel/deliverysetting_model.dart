class DeliverySettings {
  final double pricePerKm;
  final double minimumDeliveryFee;

  DeliverySettings({
    required this.pricePerKm,
    required this.minimumDeliveryFee,
  });

  factory DeliverySettings.fromJson(Map<String, dynamic> json) {
    return DeliverySettings(
      pricePerKm: double.parse(json['price_per_km'].toString()),
      minimumDeliveryFee: double.parse(json['minimum_delivery_fee'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "price_per_km": pricePerKm,
      "minimum_delivery_fee": minimumDeliveryFee,
    };
  }
}
