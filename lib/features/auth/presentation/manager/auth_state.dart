import 'package:equatable/equatable.dart';
import 'package:maadati/features/auth/data/model/auth_response.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final AuthResponse authResponse;

  const AuthSuccess(this.authResponse);

  @override
  List<Object?> get props => [authResponse];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
