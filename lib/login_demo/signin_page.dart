import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfirebaseauth/login_demo1/firebase_demo.dart';
import 'package:vfirebaseauth/login_demo/phoneauth_page.dart';

class LoginSignIn extends StatefulWidget {
  const LoginSignIn({Key? key}) : super(key: key);

  @override
  _LoginSignInState createState() => _LoginSignInState();
}

class _LoginSignInState extends State<LoginSignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(controller: emailController),
            TextFormField(controller: passController),
            ElevatedButton(
              onPressed: () {
                FirebaseHelper.signIn(
                  email: emailController.text,
                  password: passController.text,
                );
              },
              child: Text("Sign In"),
            ),
            TextButton(
              onPressed: () {
                Get.to(phoneAuthPage());
              },
              child: Text("Sign Up with Phone No."),
            ),
          ],
        ),
      ),
    );
  }
}
