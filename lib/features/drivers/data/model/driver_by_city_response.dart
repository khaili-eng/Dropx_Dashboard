class DriverByCityResponse {
  final bool status;
  final String message;
  final List<DriverByCityModel> data;

  DriverByCityResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverByCityResponse.fromJson(Map<String, dynamic> json) {
    return DriverByCityResponse(
      status: json['status'],
      message: json['message'],
      data: List<DriverByCityModel>.from(
        json['data'].map((e) => DriverByCityModel.fromJson(e)),
      ),
    );
  }
}

// ================= DRIVER =================
class DriverByCityModel {
  final int id;
  final int userId;
  final String vehicleType;
  final String vehicleNumber;
  final bool isActive;
  final DriverUserModel user;

  DriverByCityModel({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.vehicleNumber,
    required this.isActive,
    required this.user,
  });

  factory DriverByCityModel.fromJson(Map<String, dynamic> json) {
    return DriverByCityModel(
      id: json['id'],
      userId: json['user_id'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
      isActive: json['is_active'] == 1, // لأنه int
      user: DriverUserModel.fromJson(json['user']),
    );
  }
}

// ================= USER =================
class DriverUserModel {
  final int id;
  final String fullname;
  final String phone;

  DriverUserModel({
    required this.id,
    required this.fullname,
    required this.phone,
  });

  factory DriverUserModel.fromJson(Map<String, dynamic> json) {
    return DriverUserModel(
      id: json['id'],
      fullname: json['fullname'],
      phone: json['phone'],
    );
  }
}