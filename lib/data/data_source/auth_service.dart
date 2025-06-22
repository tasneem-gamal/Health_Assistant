import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<UserCredential> signUp({
    required String email,
    required String password,
  }) async {
    return await auth.createUserWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<UserCredential> login({
    required String email,
    required String password,
  }) async {
    return await auth.signInWithEmailAndPassword(
      email: email, 
      password: password
    );
  }

  Future<void> signOut() async{
    await auth.signOut();
  }

  Future<void> sendOTP({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
    required Function(String error) onFailed,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        onFailed(e.message ?? "Verification failed");
      },
      codeSent: (String verificationId, int? resendToken) {
        onCodeSent(verificationId);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  Future<void> verifyOTPAndResetPassword({
    required String verificationId,
    required String smsCode,
    required String newPassword,
  }) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: smsCode,
    );

    final userCredential = await auth.signInWithCredential(credential);
    await userCredential.user?.updatePassword(newPassword);
  }

  Future<void> updateUserProfile({
    String? name,
    String? email,
    String? phone,
    String? password,
  }) async {
    final user = auth.currentUser;
    if (user == null) throw Exception("User not logged in");

    if (email != null && email != user.email) {
      await user.verifyBeforeUpdateEmail(email);
    }

    if (password != null && password.isNotEmpty) {
      await user.updatePassword(password);
    }

    if (name != null && name.isNotEmpty) {
      await user.updateDisplayName(name);
    }

    await firestore.collection("users").doc(user.uid).update({
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
    });
  }

  Future<void> reAuthenticateUser(String email, String password) async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final credential = EmailAuthProvider.credential(email: email, password: password);
    await user.reauthenticateWithCredential(credential);
  }
}

}