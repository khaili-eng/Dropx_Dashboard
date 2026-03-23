import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maadati/core/network/api/api_error.dart';
import 'package:maadati/features/auth/data/model/auth_response.dart';
import 'package:maadati/features/auth/repo/auth_repo.dart';

import '../../../../core/utils/pref_helper.dart';
import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;

  AuthCubit(this.authRepo) : super(AuthInitial());

  /// Login
  Future<void> login({
    required String phone,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      final AuthResponse response =
      await authRepo.login(phone, password);

      emit(AuthSuccess(response));
    } on ApiError catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(const AuthFailure("Something went wrong"));
    }
  }

  /// Logout
  Future<void> logout() async {
    emit(AuthLoading());


    await PrefHelper.clearToken();

    emit(AuthInitial());
  }
}