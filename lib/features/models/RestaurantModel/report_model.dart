class Report {
  final int totalOrders;
  final int deliveredOrders;
  final int canceledOrders;
  final double totalRevenue;

  Report({
    required this.totalOrders,
    required this.deliveredOrders,
    required this.canceledOrders,
    required this.totalRevenue,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      totalOrders: json['total_orders'] ?? 0,
      deliveredOrders: json['delivered_orders'] ?? 0,
      canceledOrders: json['canceled_orders'] ?? 0,
      totalRevenue: (json['total_revenue'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_orders': totalOrders,
      'delivered_orders': deliveredOrders,
      'canceled_orders': canceledOrders,
      'total_revenue': totalRevenue,
    };
  }
}
