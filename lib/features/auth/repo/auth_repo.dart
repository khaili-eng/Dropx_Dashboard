
import 'package:maadati/features/auth/data/model/auth_response.dart';

abstract class AuthRepo{

  //login
  Future<AuthResponse>login(String phone,String password);
}