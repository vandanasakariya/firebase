import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vfirebaseauth/login_demo1/data_login.dart';
import 'package:vfirebaseauth/login_demo1/firebase_demo.dart';
import 'package:vfirebaseauth/login_demo1/signin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Firebase Demo"),
        ),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
              child: TextFormField(controller: emailController),
            ),
            TextFormField(controller: passController),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseHelper.signUp(
                  email: emailController.text,
                  password: passController.text,
                );
                Get.to(SignInPage());
              },
              child: Text("Sign Up"),
            ),
            SizedBox(
              height: 3.h,
            ),
            /*  ElevatedButton(
              onPressed: () {
                FirebaseHelper.signIn(
                  email: emailController.text,
                  password: passController.text,
                );
                Get.to(SignInPage());
              },
              child: Text("Sign In"),
            ),
            SizedBox(
              height: 3.h,
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseHelper.signOut();
                //Get.to(SignInPage());
              },
              child: Text("Sign Out"),
            ),*/
          ],
        ),
      ),
    );
  }
}
