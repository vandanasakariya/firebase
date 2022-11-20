import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:vfirebaseauth/login_demo/opt_screen.dart';

class phoneAuthPage extends StatefulWidget {
  const phoneAuthPage({Key? key}) : super(key: key);

  @override
  _phoneAuthPageState createState() => _phoneAuthPageState();
}

class _phoneAuthPageState extends State<phoneAuthPage> {
  TextEditingController numberController = TextEditingController();
  static String email = "";
  bool isLogin = true;
  Map? objdata = {};
  void sendOTP() async {
    String phone = "+91" + numberController.text.trim();

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        codeSent: (verificationId, resendToken) {
          Navigator.push(
            context,
            CupertinoPageRoute(
              builder: (context) =>
                  OtpScreenPage(verificationId: verificationId),
            ),
          );
        },
        verificationCompleted: (credential) {},
        verificationFailed: (ex) {
          log(ex.code.toString());
        },
        codeAutoRetrievalTimeout: (verificationId) {},
        timeout: Duration(seconds: 30));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextFormField(
              controller: numberController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                sendOTP();
              },
              child: Text("Sent OTP "),
            ),
            SizedBox(height: 20),
            Text("User Email"),
            ElevatedButton(
              onPressed: () {
                Future<UserCredential> signInWithGoogle() async {
                  // Trigger the authentication flow
                  final GoogleSignInAccount? googleUser =
                      await GoogleSignIn().signIn();

                  // Obtain the auth details from the request
                  final GoogleSignInAuthentication? googleAuth =
                      await googleUser?.authentication;

                  // Create a new credential
                  final credential = GoogleAuthProvider.credential(
                    accessToken: googleAuth?.accessToken,
                    idToken: googleAuth?.idToken,
                  );
                  email = googleUser!.email;
                  // Once signed in, return the UserCredential
                  return await FirebaseAuth.instance
                      .signInWithCredential(credential);
                }

                setState(() {});
              },
              // icon: const FaIcon(
              //   FontAwesomeIcons.google,
              // ),
              child: Text("Sign in google"),
            ),
            ElevatedButton(
              onPressed: () async {
                log('--------facebook');
                try {
                  final LoginResult result = await FacebookAuth.instance.login(
                      permissions: [
                        'email',
                        'public_profile',
                        'user_birthday'
                      ]);
                  FacebookAuth.instance
                      .getUserData(fields: "email,birthday,public_profile")
                      .then(
                        (value) => setState(() {
                          objdata = value;
                          isLogin = false;
                          log('userData :$value');
                        }),
                      );
                  log('facebookLoginResult :${result.toString()}');
                  if (result.status == LoginStatus.success) {
                    // you are logged
                    final AccessToken accessToken = result.accessToken!;
                    log("accessToken ===${accessToken.token}");
                    log("accessToken ===${accessToken.userId}");
                  } else {
                    log("result.status ===${result.status}");
                    log("result.message ===${result.message}");
                  }
                } catch (e, st) {
                  log("error ===${e} ===stack===$st");
                }
              },
              child: Text("Fb"),
            ),
          ],
        ),
      ),
    );
  }
}
