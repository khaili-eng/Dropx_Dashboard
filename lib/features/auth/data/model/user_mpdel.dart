class UserModel{
  final int id;
  final String fullName;
  final String phone;
  final String?locationText;
  final double?latitude;
  final double?longitude;
  final bool isActive;
  final bool isVerified;
  UserModel({
    required this.id,
    required this.fullName,
    required this.phone,
    this.locationText,
    this.latitude,
    this.longitude,
    required this.isActive,
    required this.isVerified,
});
factory UserModel.fromJson(Map<String,dynamic>json){
  return UserModel(
      id: json['id'],
      fullName: json['fullname'],
      phone: json['phone'],
      locationText: json['location_text'],
      latitude: json['latitude']!=null ? (json['latitude'] as num).toDouble():null,
      longitude: json['longitude']!=null ? (json['longitude'] as num).toDouble() : null,
      isActive: json['is_active'],
      isVerified: json['is_verified']
  );
}
Map<String,dynamic> toJSon(){
  return {
    'id':id,
    'fullname':fullName,
    'phone':phone,
    'location_text':locationText,
    'latitude':latitude,
    'longitude':longitude,
    'is_active':isActive,
    'is_verified':isVerified,
  };
}


}