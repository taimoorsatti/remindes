import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:uuid/uuid.dart';

String docId = Uuid().v4();

StreamSubscription<ConnectivityResult> _connectivitySubscription =
    _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
final Connectivity _connectivity = Connectivity();
ConnectivityResult connectionStatus = ConnectivityResult.none;

Future<void> initConnectivity() async {
  ConnectivityResult result;
  // Platform messages may fail, so we use a try/catch PlatformException.
  try {
    result = await _connectivity.checkConnectivity();
  } catch (e) {
    print(e);
    return;
  }
  return _updateConnectionStatus(result);
}

Future<void> _updateConnectionStatus(ConnectivityResult result) async {
  connectionStatus = result;
}




class GradientText extends StatelessWidget {
  const GradientText(
      this.text, {
        required this.gradient,
        this.style,
      });

  final String text;
  final TextStyle? style;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style: style),
    );
  }
}

class NewBannerAdd extends StatefulWidget {
  const NewBannerAdd({Key? key}) : super(key: key);

  @override
  NewBannerAddState createState() => NewBannerAddState();
}

class NewBannerAddState extends State<NewBannerAdd>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  late BannerAd myBanner;

  @override
  void initState() {
    super.initState();
    myBanner = BannerAd(
      adUnitId: "ca-app-pub-1430798905214602/6920280616",
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => print('Ad loaded.'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          print(error.message);
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
      height: myBanner.size.height.toDouble(),
      child: AdWidget(ad: myBanner),
    );
  }
}