import 'package:maadati/features/auth/data/model/user_mpdel.dart';

import '../../../../core/network/api/api_error.dart';

class AuthResponse{
  final UserModel user;
  final String message;
  final String token;
  AuthResponse({
    required this.user,
    required this.message,
    required this.token
});
  factory AuthResponse.fromJson(Map<String,dynamic> json){
    return AuthResponse(
        user: json['user'] != null
            ? UserModel.fromJson(json['user'])
            : throw ApiError(message: "User data missing"),
        message: json['message'],
        token: json['token']);
  }
}