import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfirebaseauth/login_auth/firebase_helper.dart';
import 'package:vfirebaseauth/login_auth/phone_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(controller: emailController),
            TextFormField(controller: passwordController),
            ElevatedButton(
              onPressed: () {
                FireBaseHelperClass.signIn(
                  email: emailController.text,
                  password: passwordController.text,
                );
              },
              child: Text("Login"),
            ),
            TextButton(
              onPressed: () {
                Get.to(PhoneAuth());
              },
              child: Text("Sign in Phone No."),
            ),
          ],
        ),
      ),
    );
  }
}
