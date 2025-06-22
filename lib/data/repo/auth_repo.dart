import 'package:health_assistant/data/data_source/auth_service.dart';

class AuthRepo {
  final AuthService authService;

  AuthRepo(this.authService);

  Future<String> signUp({
    required String email,
    required String password,
  }) async {
    final userCredential = await authService.signUp(email: email, password: password);
    return userCredential.user!.uid;
  }

  Future<String> login({
    required String email,
    required String password,
  }) async {
    final userCredential = await authService.login(email: email, password: password);
    return userCredential.user!.uid;
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

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    await authService.updateUserProfile(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
  }

  Future<void> reAuthenticateUser(String email, String password) async {
  await authService.reAuthenticateUser(email, password);
}

}