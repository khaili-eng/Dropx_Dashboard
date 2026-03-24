class Order {
  final int id;
  final int restaurantId;
  final String status;
  final double totalAmount;
  final DateTime createdAt;
  final List<OrderItem> items;

  Order({
    required this.id,
    required this.restaurantId,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      restaurantId: json['restaurant_id'],
      status: json['status'],
      totalAmount: (json['total_amount'] as num).toDouble(),
      createdAt: DateTime.parse(json['created_at']),
      items:
          (json['items'] as List)
              .map((item) => OrderItem.fromJson(item))
              .toList(),
    );
  }
}

class OrderItem {
  final int id;
  final String name;
  final int quantity;
  final double price;

  OrderItem({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }
}
