import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/screens/onboarding/onboarding_view.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../utils/constants.dart';
import '../event/event_view.dart';
import '../login_signup/login/login_view.dart';
import '../onboarding/components/newonboarding.dart';

class splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return splashState();
  }
}

class splashState extends State<splash> {
  @override
  late AppLifecycleReactor appLifecycleReactor;


  void initState() {
    super.initState();
    AppOpenAdManager appOpenAdManager = AppOpenAdManager()..loadAd();
    appLifecycleReactor = AppLifecycleReactor(
        appOpenAdManager: appOpenAdManager);
    appLifecycleReactor.listenToAppStateChanges();

    Future.delayed(const Duration(seconds: 2), () async {
      // String token = await Shared_pref_helper().getAuthToken();
      // if (token != null && token.isNotEmpty) {
      //   Get.offAll(HomeScreen());
      // } else {
      sessionManager.isUserLogin?
      Get.offAllNamed(EventScreen.routeName):
      Get.offAllNamed(OnboardingScreen.routeName);
      // }
    });
  }
  SessionManager sessionManager= SessionManager();

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Color(0xff3c65b0),
        statusBarColor: Color(0xff4099d4),
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(AppAssets.backIcon,fit: BoxFit.cover,),
        ),
      ), // add image text or whatever you want as splash
    );
  }
}



class AppLifecycleReactor {
  final AppOpenAdManager appOpenAdManager;

  AppLifecycleReactor({required this.appOpenAdManager});

  void listenToAppStateChanges() {
    AppStateEventNotifier.startListening();
    AppStateEventNotifier.appStateStream
        .forEach((state) => _onAppStateChanged(state));
  }

  void _onAppStateChanged(AppState appState) {
    // Try to show an app open ad if the app is being resumed and
    // we're not already showing an app open ad.
    if (appState == AppState.foreground) {
      appOpenAdManager.showAdIfAvailable();
    }
  }
}

 class AppOpenAdManager {

   AppOpenAd? _appOpenAd;
   bool _isShowingAd = false;


   void loadAd() {
     AppOpenAd.load(
       adUnitId: "ca-app-pub-1430798905214602/1730435634",
       orientation: AppOpenAd.orientationPortrait,
       request: const AdRequest(),
       adLoadCallback: AppOpenAdLoadCallback(
         onAdLoaded: (ad) {
           _appOpenAd = ad;
           _appOpenAd!.show();
         },
         onAdFailedToLoad: (error) {
           print('AppOpenAd failed to load: $error');
         },
       ),
     );
   }

   void showAdIfAvailable() {
       print('Tried to show ad before available.');
       loadAd();
       return;

     if (_isShowingAd) {
       print('Tried to show ad while already showing an ad.');
       return;
     }
   }
   bool get isAdAvailable {
     return _appOpenAd != null;
   }
 }