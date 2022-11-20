import 'package:firebase_auth/firebase_auth.dart';

class FireBaseHelperClass {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future? signIn({
    required String email,
    required String password,
  }) {
    _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}
