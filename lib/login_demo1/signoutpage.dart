import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vfirebaseauth/login_demo1/firebase_demo.dart';
import 'package:vfirebaseauth/login_demo1/login_page.dart';
import 'package:vfirebaseauth/login_demo1/signin_page.dart';

class SignOutPage extends StatefulWidget {
  const SignOutPage({
    Key? key,
  }) : super(key: key);

  @override
  _SignOutPageState createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Text("${FirebaseAuth.instance.currentUser?.email}"),
            ElevatedButton(
                onPressed: () {
                  FirebaseHelper.signOut();
                  Get.to(SignInPage());
                },
                child: Text("Sign Out"))
          ],
        ),
      ),
    );
  }
}
