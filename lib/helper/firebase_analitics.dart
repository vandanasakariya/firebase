import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsUtils {
  static late FirebaseAnalytics analytics;
  static late FirebaseAnalyticsObserver observer;

  static const String home = 'homeScreen';
  static const String biuton = 'login';

  static void init() {
    analytics = FirebaseAnalytics.instance;
    observer = FirebaseAnalyticsObserver(analytics: analytics);
  }

  static void sendCurrentScreen(String screenName) async {
    await analytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: screenName,
    );
  }

  static void sendAnalyticsEvent(String buttonClick) async {
    await analytics.logEvent(
      name: buttonClick,
    );
  }
}
