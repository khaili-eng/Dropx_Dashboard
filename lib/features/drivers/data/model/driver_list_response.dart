import 'driver_item_model.dart';

class DriverListResponse {
  final bool status;
  final String message;
  final List<DriverItemModel> data;

  DriverListResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  factory DriverListResponse.fromJson(Map<String, dynamic> json) {
    return DriverListResponse(
      status: json['status'],
      message: json['message'],
      data: List<DriverItemModel>.from(
        json['data'].map((e) => DriverItemModel.fromJson(e)),
      ),
    );
  }
}

// ================= ITEM =================


// ================= DRIVER INFO =================
class DriverInfoModel {
  final int id;
  final int userId;
  final String vehicleType;
  final String vehicleNumber;

  DriverInfoModel({
    required this.id,
    required this.userId,
    required this.vehicleType,
    required this.vehicleNumber,
  });

  factory DriverInfoModel.fromJson(Map<String, dynamic> json) {
    return DriverInfoModel(
      id: json['id'],
      userId: json['user_id'],
      vehicleType: json['vehicle_type'],
      vehicleNumber: json['vehicle_number'],
    );
  }
}