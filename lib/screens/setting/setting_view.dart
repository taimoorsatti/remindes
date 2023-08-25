import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/controllers/setting/setting_controller.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../widget/terms_policy.dart';
import '../addevent/add_event_view.dart';
import '../myevent/tableclander.dart';
import 'components/body.dart';
import 'components/privacy_policy/privacy_policy_view.dart';

class SettingView extends StatefulWidget {
  static const routeName="/setting";
  const SettingView({Key? key}) : super(key: key);

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  int _index = 2;
  bool isLoading=true;
  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());
  SettingController settingController = Get.put(SettingController());
  TermsPolicy privacySetting=Get.put(TermsPolicy());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
  }


  @override
  Widget build(BuildContext context) {



    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor:Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return GetBuilder(
      init: SettingController(),
      builder: (SettingController viewModel) {
        return SafeArea(
          child: Scaffold(
            extendBody: true,
            backgroundColor: Constant.backgroundColor,
            bottomNavigationBar: FloatingNavbar(
              width: Get.width - 120.w,
              selectedBackgroundColor: Colors.white,
              borderRadius: 40.r,
              selectedItemColor: Constant.secondaryColor,
              unselectedItemColor: Colors.grey,
              backgroundColor: Colors.white,
              elevation: 100,
              onTap: (int val) {
                setState(() {
                  _index = val;
                });
                if (val == 1) {
                  Get.offAllNamed(TableEventsExample.routeName);
                } else if (val == 0) {
                  Get.offAllNamed(EventScreen.routeName);
                }
              },
              currentIndex: _index,
              items: [
                FloatingNavbarItem(
                  icon: Icons.home,
                ),
                FloatingNavbarItem(icon: Icons.list_alt_sharp),
                FloatingNavbarItem(
                  icon: Icons.settings,
                ),
              ],
            ),
            body: SafeArea(child: Stack(
              children: [
                isLoading?Center(
                  child:Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp),
                ):Container(),
                SettingBody(),
              ],
            )),
          ),
        );
      }
    );
  }
}
