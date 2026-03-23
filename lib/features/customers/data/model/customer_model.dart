class CustomerModel{
  final int id;
  final String fullname;
  final String phone;
  final String? locationText;
  final bool isActive;
  CustomerModel({
   required this.id,
   required this.fullname,
   required this.phone,
   this.locationText,
   required this.isActive,
});
  factory CustomerModel.fromJson(Map<String,dynamic>json){
    return CustomerModel(
        id: json['id'],
        fullname: json['fullname'],
        phone: json['phone'],
        locationText: json['location_text'],
      isActive: json['is_active']
    );
  }
  Map<String,dynamic>toJson(){
    return {
      'id':id,
      'fullname':fullname,
      'phone':phone,
      'location_text':locationText,
      'is_active':isActive,
    };
  }
  
  //add copy with 
CustomerModel copyWith({
    int?id,
  String? fullname,
  String?phone,
  String?locationText,
  bool?isActive,
}){
    return CustomerModel(
        id: id??this.id,
        fullname: fullname??this.fullname,
        phone: phone??this.phone,
        locationText: locationText??this.locationText,
        isActive: isActive??this.isActive
    );
}
}