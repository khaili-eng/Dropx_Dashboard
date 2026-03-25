class Restaurants {
  final String? fullname;
  final String? phone;
  final String? city;
  final String? description;
  final String? commissionType;
  final double? commissionValue;
  final String? image;
  final String? password;
  Restaurants({
    this.fullname,
    this.phone,
    this.city,
    this.description,
    this.commissionType,
    this.commissionValue,
    this.image,
    this.password,
  });

  factory Restaurants.fromJson(Map<String, dynamic> json) {
    return Restaurants(
      fullname: json['fullname'],
      phone: json['phone'],
      city: json['city'],
      description: json['description'],
      commissionType: json['commission_type'],
      commissionValue: json['commission_value']?.toDouble(),
      image: json['image'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'phone': phone,
      'city': city,
      'description': description,
      'commission_type': commissionType,
      'commission_value': commissionValue,
      'image': image,
      'password': password,
    };
  }
}
