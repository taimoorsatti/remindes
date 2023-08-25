//
// import 'package:get/get.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:flutter/material.dart';
// import 'package:remindly_app/screens/event/event_view.dart';
//
// class SplashScree extends StatefulWidget {
//   SplashScreen({Key? key}) : super(key: key);
//
//   @override
//   // ignore: library_private_types_in_public_api
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     _createInterstitialAd();
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     _interstitialAd?.dispose();
//     super.dispose();
//   }
//
//   InterstitialAd? _interstitialAd;
//   int _numInterstitialLoadAttempts = 0;
//   int maxFailedLoadAttempts = 3;
//
//   void _createInterstitialAd() {
//     InterstitialAd.load(
//       adUnitId: "ca-app-pub-3940256099942544/1033173712",
//       request: AdRequest(),
//       adLoadCallback: InterstitialAdLoadCallback(
//         onAdLoaded: (InterstitialAd ad) {
//           _interstitialAd = ad;
//           _numInterstitialLoadAttempts = 0;
//           _showInterstitialAd();
//         },
//         onAdFailedToLoad: (LoadAdError error) {
//           _numInterstitialLoadAttempts += 1;
//           _interstitialAd = null;
//           if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
//             _createInterstitialAd();
//           } else {
//             Get.offAll(EventScreen());
//           }
//         },
//       ),
//     );
//   }
//
//   void _showInterstitialAd() {
//     if (_interstitialAd == null) {
//       print('Warning: attempt to show interstitial before loaded.');
//       return;
//     }
//     _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
//       onAdDismissedFullScreenContent: (InterstitialAd ad) {
//         ad.dispose();
//         Get.offAll(EventScreen());
//       },
//     );
//     _interstitialAd!.show();
//     _interstitialAd = null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Text("Your Splash Screen"),
//         ),
//       ),
//     );
//   }
// }
