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

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String) onCodeSent,
    required Function(String) onFailed,
  }) async {
    await authService.sendOTP(
      phoneNumber: phoneNumber,
      onCodeSent: onCodeSent,
      onFailed: onFailed,
    );
  }

  Future<void> verifyOTPAndResetPassword({
    required String verificationId,
    required String smsCode,
    required String newPassword,
  }) async {
    await authService.verifyOTPAndResetPassword(
      verificationId: verificationId,
      smsCode: smsCode,
      newPassword: newPassword,
    );
  }
}