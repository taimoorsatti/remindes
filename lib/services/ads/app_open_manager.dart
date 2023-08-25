import 'package:google_mobile_ads/google_mobile_ads.dart';

 class AdsApp{
 static InterstitialAd? interstitialAd;
 static int numInterstitialLoadAttempts = 0;
 static int maxFailedLoadAttempts = 3;

 static void  createInterstitialAd() {
    InterstitialAd.load(
      adUnitId: "ca-app-pub-1430798905214602/1476382249",
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          interstitialAd = ad;
          numInterstitialLoadAttempts = 0;
          _showInterstitialAd();
        },
        onAdFailedToLoad: (LoadAdError error) {
          numInterstitialLoadAttempts += 1;
          interstitialAd = null;
          if (numInterstitialLoadAttempts < maxFailedLoadAttempts) {
            createInterstitialAd();
          } else {

          }
        },
      ),
    );
  }

  static void _showInterstitialAd() {
    if (interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        ad.dispose();
      },
    );
    interstitialAd!.show();
    interstitialAd = null;
  }

}
