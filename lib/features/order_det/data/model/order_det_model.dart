class OrderResponse {
  final bool status;
  final String message;
  final OrderData data;

  OrderResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory OrderResponse.fromJson(Map<String, dynamic> json) {
    return OrderResponse(
      status: json['status'],
      message: json['message'],
      data: OrderData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'message': message,
    'data': data.toJson(),
  };
}

// ================= ORDER DATA =================

class OrderData {
  final int id;
  final int userId;
  final int restaurantId;
  final int? driverId;
  final String status;
  final int isAccepted;
  final double totalPrice;
  final String? deliveryAddress;
  final String latitude;
  final String longitude;
  final String? notes;
  final double deliveryFee;
  final String barcode;
  final String? createdAt;
  final String? updatedAt;

  final User user;
  final Restaurant restaurant;
  final Driver? driver;
  final List<OrderItem> orderItems;

  OrderData({
    required this.id,
    required this.userId,
    required this.restaurantId,
    this.driverId,
    required this.status,
    required this.isAccepted,
    required this.totalPrice,
    this.deliveryAddress,
    required this.latitude,
    required this.longitude,
    this.notes,
    required this.deliveryFee,
    required this.barcode,
    this.createdAt,
    this.updatedAt,
    required this.user,
    required this.restaurant,
    this.driver,
    required this.orderItems,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['id'],
      userId: json['user_id'],
      restaurantId: json['restaurant_id'],
      driverId: json['driver_id'],
      status: json['status'],
      isAccepted: json['is_accepted'],
      totalPrice: double.parse(json['total_price']),
      deliveryAddress: json['delivery_address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      notes: json['notes'],
      deliveryFee: double.parse(json['delivery_fee']),
      barcode: json['barcode'] ?? '',
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
      restaurant: Restaurant.fromJson(json['restaurant']),
      driver: json['driver'] != null ? Driver.fromJson(json['driver']) : null,
      orderItems:
          (json['order_items'] as List)
              .map((e) => OrderItem.fromJson(e))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'restaurant_id': restaurantId,
    'driver_id': driverId,
    'status': status,
    'is_accepted': isAccepted,
    'total_price': totalPrice,
    'delivery_address': deliveryAddress,
    'latitude': latitude,
    'longitude': longitude,
    'notes': notes,
    'delivery_fee': deliveryFee,
    'barcode': barcode,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'user': user.toJson(),
    'restaurant': restaurant.toJson(),
    'driver': driver?.toJson(),
    'order_items': orderItems.map((e) => e.toJson()).toList(),
  };
}

// ================= USER =================

class User {
  final int id;
  final String fullname;
  final String phone;

  User({required this.id, required this.fullname, required this.phone});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      fullname: json['fullname'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'fullname': fullname,
    'phone': phone,
  };
}

// ================= RESTAURANT =================

class Restaurant {
  final int id;
  final int userId;
  final String image;

  Restaurant({required this.id, required this.userId, required this.image});

  factory Restaurant.fromJson(Map<String, dynamic> json) {
    return Restaurant(
      id: json['id'],
      userId: json['user_id'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'image': image,
  };
}

// ================= DRIVER =================

class Driver {
  final int id;
  final int userId;
  final String vehicleType;
  final String vehicleNumber;
  final int isActive;
  final String createdAt;
  final String updatedAt;
  final User user;

  Driver({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      id: json['id'],
      userId: json['user_id'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      isActive: json['is_active'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'user_id': userId,
    'vehicle_type': vehicleType,
    'vehicle_number': vehicleNumber,
    'is_active': isActive,
    'created_at': createdAt,
    'updated_at': updatedAt,
    'user': user.toJson(),
  };
}

// ================= ORDER ITEM =================

class OrderItem {
  OrderItem();

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem();
  }

  Map<String, dynamic> toJson() => {};
}
