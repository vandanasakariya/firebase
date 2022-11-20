import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OtpScreenPage extends StatefulWidget {
  final String verificationId;
  const OtpScreenPage({
    Key? key,
    required this.verificationId,
  }) : super(key: key);

  @override
  _OtpScreenPageState createState() => _OtpScreenPageState();
}

class _OtpScreenPageState extends State<OtpScreenPage> {
  final TextEditingController optController = TextEditingController();
  void verifyOTP() async {
    String otp = optController.text.trim();

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
              controller: optController,
            ),
            ElevatedButton(
              onPressed: () async {
                verifyOTP;
              },
              child: Text("Sent OTP Page"),
            ),
          ],
        ),
      ),
    );
  }
}
