import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/screens/login_signup/login/login_view.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../widget/app_button.dart';




class OnboardingButton extends StatelessWidget {

  OnboardingButton({Key? key}) : super(key: key);
  SessionManager sessionManager=SessionManager();

  @override
  Widget build(BuildContext context) {
    return AppButton(
      fontFamily: "Quicksand",
      minBtnHeight: 55.h,
      borderRadius: 25.r,
      maxBtnHeight: 55.h,
      fontSize: 24,
      fontWeight:FontWeight.w600 ,
      text: 'Get Started',
      onClick: () {
        FocusScope.of(context).unfocus();
        Get.offNamed(LoginViewScreen.routeName);
      },
      color: Colors.white,
      textColor: Constant.primaryColor,
    );
  }
}