import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:sizer/sizer.dart';
import 'package:vfirebaseauth/login_demo1/signoutpage.dart';

import 'firebase_demo.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              FirebaseHelper.signIn(
                email: emailController.text,
                password: passController.text,
              );
              Get.to(SignOutPage());
            },
            child: Text("Sign In"),
          ),
          SizedBox(
            height: 3.h,
          ),
        ],
      ),
    );
  }
}
