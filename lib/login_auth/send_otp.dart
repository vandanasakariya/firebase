import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendOtp extends StatefulWidget {
  final String verificationId;
  const SendOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  _SendOtpState createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  TextEditingController sendOtpController = TextEditingController();
  void verifyOTP() async {
    String otp = sendOtpController.text.trim();

    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      if (userCredential.user != null) {
        Navigator.popUntil(context, (route) => route.isFirst);
        // Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => HomePage()));
      }
    } on FirebaseAuthException catch (ex) {
      log(ex.code.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: sendOtpController,
            ),
            ElevatedButton(
              onPressed: () {
                verifyOTP();
              },
              child: Text("send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
