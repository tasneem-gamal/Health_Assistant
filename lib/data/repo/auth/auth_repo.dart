import 'package:health_assistant/data/data_source/auth/auth_service.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    await authService.signUp(email: email, password: password);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    await authService.login(email: email, password: password);
  }

  Future<void> signOut() async {
    await authService.signOut();
  }
}