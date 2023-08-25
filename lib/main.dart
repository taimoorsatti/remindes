

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import 'package:remindly_app/screens/onboarding/onboarding_view.dart';
import 'package:remindly_app/screens/route_generator.dart';
import 'package:remindly_app/screens/splash/splash.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await Firebase.initializeApp(
  );
  await FirebaseAppCheck.instance
      .activate(
    androidProvider: AndroidProvider.playIntegrity,
    appleProvider: AppleProvider.appAttest,
  );

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

   await initApp();
  runApp(const MyApp());

}

initApp() async {
   GetStorage.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(375, 800),
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'remindly',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: '/',
            routes: {
              '/':(context)=> splash(),
            },
          );
        });
  }
}
