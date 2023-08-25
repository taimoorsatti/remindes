import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/screens/setting/setting_view.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../controllers/addevent/add_event_controller.dart';
import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../controllers/event/upcoming/upcoming_controller.dart';
import '../../controllers/setting/setting_controller.dart';
import '../myevent/tableclander.dart';
import 'components/body.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class EventScreen extends StatefulWidget {
  static const routeName="/eventScreen";
  EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  UpComingController upComingController = Get.put(UpComingController());
  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());
  SettingController settingController = Get.put(SettingController());
  int _index = 0;


  @override
  void initState() {
    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
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
            if(val==1){
              Get.offAllNamed(
                TableEventsExample.routeName,
              );

            }else if(val==2){
              settingController.checkAnonymous();
              Get.offAllNamed(
                SettingView.routeName,
              );
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
        body:
        EventBody(),
      ),
    );
  }
}
