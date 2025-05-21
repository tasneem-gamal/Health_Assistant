import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_assistant/data/repo/auth/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepo) : super(AuthInitial());

  final AuthRepo authRepo;

  Future<void> emitSignUpState({
    required String email,
    required String password,
    required String phone,
  }) async {
    emit(AuthLoading());

    try {
      await authRepo.signUp(email: email, password: password);
      emit(AuthSuccess("Success"));
    } catch (e) {
      emit(AuthFailure("Failure: ${e.toString()}"));
    }
  }

  Future<void> emitLoginState({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    try {
      await authRepo.login(email: email, password: password);
      emit(AuthSuccess("Success"));
    } catch (e) {
      emit(AuthFailure("Failure: ${e.toString()}"));
    }
  }
}
