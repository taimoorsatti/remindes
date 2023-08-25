import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class checkbanner extends StatefulWidget {
  const checkbanner({Key? key}) : super(key: key);

  @override
  _checkbannerState createState() => _checkbannerState();
}

class _checkbannerState extends State<checkbanner> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          if (index != 0 && index % 5 == 0) {
            return const _BannerAd();
          }

          return Container(
            height: 200,
            color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withOpacity(1),
          );
        },
      ),
    );
  }
}

class _BannerAd extends StatefulWidget {
  const _BannerAd({Key? key}) : super(key: key);

  @override
  _BannerAdState createState() => _BannerAdState();
}

class _BannerAdState extends State<_BannerAd>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late BannerAd myBanner;

  @override
  void initState() {
    super.initState();
    myBanner = BannerAd(
      adUnitId: "ca-app-pub-3940256099942544/3419835294",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Ad loaded.'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print('Ad failed to load .');
        },
        onAdOpened: (ad) => print('Ad opened.'),
        onAdClosed: (ad) => print('Ad closed.'),
        onAdImpression: (ad) => print('Ad impression.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    myBanner.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      width: myBanner.size.width.toDouble(),
      height: myBanner.size.height.toDouble(),
      margin: const EdgeInsets.all(20),
      alignment: Alignment.center,
      child: AdWidget(ad: myBanner),
    );
  }
}