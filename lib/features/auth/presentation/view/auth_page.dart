import 'package:flutter/material.dart';
import 'package:maadati/features/auth/presentation/widgets/login_form.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: LoginForm());
  }
}
