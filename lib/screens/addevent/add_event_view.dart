import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/controllers/addevent/add_event_controller.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/screens/myevent/tableclander.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../widget/custom_appbar.dart';
import '../calender.dart';
import '../setting/setting_view.dart';
import 'components/body.dart';

class AddEventViewScreen extends StatefulWidget {
  static const routeName = "/addEvent";

  AddEventViewScreen({Key? key}) : super(key: key);

  @override
  State<AddEventViewScreen> createState() => _AddEventViewScreenState();
}

class _AddEventViewScreenState extends State<AddEventViewScreen> {
  AddEventController controllerAddEvent = Get.put(AddEventController());
  CheckConnectionStream checkConnectionStream =
      Get.put(CheckConnectionStream());
  int _index = 1;

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Constant.backgroundColor,
        extendBody: true,
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
            if (val == 0) {
              Get.offAllNamed(EventScreen.routeName);
            } else if (val == 2) {
              Get.offAllNamed(SettingView.routeName);
            }
          },
          currentIndex: _index,
          items: [
            FloatingNavbarItem(
              icon: Icons.home_sharp,
            ),
            FloatingNavbarItem(icon: Icons.list_alt_sharp),
            FloatingNavbarItem(
              icon: Icons.settings,
            ),
          ],
        ),
        // appBar: _appBar,
        body: AddEventBody(),
      ),
    );
  }

  PreferredSize get _appBar => PreferredSize(
        preferredSize: Size.fromHeight(50.h),
        child: AppBarItem(
          title: '',
          showBorderBottom: false,
          showLeading: false,
          prefixWidget: Container(
            child: Image.asset(
              AppAssets.backArrowPic,
              color: Color(0xff36308b),
              height: 40.h,
              width: 40.h,
            ),
          ),
        ),
      );
}
