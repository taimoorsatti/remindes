import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/screens/login_signup/login/components/body.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../controllers/checkinternet/checkinternet_controller.dart';
import '../../../controllers/signin/signin_controller.dart';
import '../../../widget/custom_appbar.dart';

// ignore: must_be_immutable
class LoginViewScreen extends StatelessWidget {
  static const routeName="/login";
   LoginViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SignInController signInController=Get.put(SignInController());
    CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Constant.backgroundColor,
        statusBarColor: Constant.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return
        SafeArea(
        child: Scaffold(
          backgroundColor: Constant.backgroundColor,
          body:SingleChildScrollView(child: LoginBody()),
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
