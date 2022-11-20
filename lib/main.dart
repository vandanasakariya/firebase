import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:vfirebaseauth/helper/firebase_analitics.dart';

import 'firebase_image/upload_image.dart';
import 'firebase_store/store_data.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  runZonedGuarded<Future<void>>(() async {
    await crashlytics.setCrashlyticsCollectionEnabled(true);
    FlutterError.onError = crashlytics.recordFlutterError;
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
    // await AppPreference.initMySharedPreferences();
    // await GetStorage.init();
    FirebaseAnalyticsUtils.init();
    runApp(MyApp());
  }, (error, stack) => crashlytics.recordError(error, stack));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (BuildContext context, Orientation orientation,
          DeviceType deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: UploadImage(),
          // home: FirebaseAuth.instance.currentUser == null
          //     ? LoginPage()
          //     : SignInPage(),
        );
      },
    );
  }
}
