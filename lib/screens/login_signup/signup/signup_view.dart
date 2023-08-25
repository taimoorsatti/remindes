import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/screens/login_signup/login/components/body.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../controllers/signup/signup_controller.dart';
import '../../../widget/custom_appbar.dart';
import 'components/body.dart';

class SignUpView extends StatelessWidget {
  static const routeName="/Signup";
   SignUpView({Key? key}) : super(key: key);
  SignUpController controllerSignUp=Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Constant.secondaryColor,
        statusBarColor: Constant.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return
      SafeArea(
        child: Scaffold(
          backgroundColor: Constant.secondaryColor,
          body:SignUpBody(),
        ),
      );
  }

  PreferredSize get _appBar => PreferredSize(
    preferredSize: Size.fromHeight(150.h),
    child:  const AppBarItem(
      title: 'Login',
      showBorderBottom: false,
      showLeading: false,
    ),
  );
}
