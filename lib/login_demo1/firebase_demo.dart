import 'package:firebase_auth/firebase_auth.dart';

class FirebaseHelper {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  static Future? signUp({
    required String email,
    required String password,
  }) {
    firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future? signIn({
    required String email,
    required String password,
  }) {
    firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  static Future? signOut() {
    firebaseAuth.signOut();
  }
}
