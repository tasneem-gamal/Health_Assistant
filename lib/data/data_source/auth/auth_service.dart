import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
}