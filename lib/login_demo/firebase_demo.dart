import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseHelper {
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  static Future? signIn({
    required String email,
    required String password,
  }) {
    firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
