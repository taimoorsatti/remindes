import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:lottie/lottie.dart';

import '../../utils/assets_image_path.dart';
import '../../utils/constants.dart';
import '../../widget/app_button.dart';

class CheckConnectionStream extends GetxController {
  bool isModalEnable = false;
  final loadingCheckConnectivity = false.obs;

  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();

      loadingCheckConnectivity.value = false;
    } on PlatformException {
      return;
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    _connectionStatus = result;

    if (result == ConnectivityResult.none) {
      if (isModalEnable != true) {
        isModalEnable = true;
        showDialogIfNotConnect();
      }
    } else {
      if (isModalEnable) {
        Get.back();
      }
      isModalEnable = false;
    }
  }

  showDialogIfNotConnect() {
    Get.dialog(
        barrierDismissible: false,
        Center(
      child: Container(
        height: 150.h,
        width: Get.width - 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.0.sp),
          child:
            loadingCheckConnectivity.value?
            Center(child: Lottie.asset('assets/gifs/Indicator-Light.json', height: 150.sp, width: 150.sp)):
            Column(
              children: [
                Image.asset(
                  AppAssets.noInternet,
                  height: 70.h,
                  width: 70.w,
                ),
                Text(
                  "Please check your internet connection and try again",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.sp,
                    decoration: TextDecoration.none,
                    color: Constant.secondaryColor,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

        ),
      ),
    ));
  }

  @override
  void onInit() {
    super.onInit();
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }

}