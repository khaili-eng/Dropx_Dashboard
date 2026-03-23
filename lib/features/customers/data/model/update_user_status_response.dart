class UpdateUserStatusResponse{
  final bool status;
  final String message;
  final bool isActive;
  UpdateUserStatusResponse({
    required this.status,
    required this.message,
    required this.isActive,
});
  factory UpdateUserStatusResponse.fromJson(Map<String,dynamic>json){
    return UpdateUserStatusResponse(
        status: json['status'],
        message: json['message'],
        isActive: json['is_active'],
    );
  }
}