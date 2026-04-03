class DriverModel{
final int id;
final int userId;
final String vehicletype;
final String vehiclenumber;
final bool isActive;
final String createdAt;
final String updatedAt;
DriverModel({
  required this.id,
  required this.userId,
  required this.vehicletype,
  required this.vehiclenumber,
  required this.isActive,
  required this.createdAt,
  required this.updatedAt
});
factory DriverModel.fromJson(Map<String,dynamic>json){
  return DriverModel(
      id: json['id']??0,
      userId:json['user_id']??0,
      vehicletype: json['vehicle_type']??"",
      vehiclenumber:json['vehicle_number']??"",
      isActive: json['is_active'] == 1 || json['is_active'] == true,
    createdAt:json['created_at']??"",
    updatedAt:json['updated_at']??""
  );
}
Map<String,dynamic>toJson(){
  return {
    'id':id,
    'user_id':userId,
    'vehicle_type':vehicletype,
    'vehicle_number':vehiclenumber,
    'is_active':isActive,
    'created_at':createdAt,
    'updated_at':updatedAt,
  };
}
}