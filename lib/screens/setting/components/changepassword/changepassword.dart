import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/setting/setting_controller.dart';
import 'package:remindly_app/screens/login_signup/login/components/Textfield.dart';
import 'package:remindly_app/screens/setting/components/changepassword/components/textfield.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../../controllers/checkinternet/checkinternet_controller.dart';
import '../../../../controllers/signup/signup_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/global.dart';
import '../../../../widget/app_button.dart';
import '../../../event/event_view.dart';
import '../../../login_signup/signup/components/Textfield.dart';

class ChangePassword extends StatelessWidget {
  static const routeName="/changePassword";
  ChangePassword({Key? key}) : super(key: key);
  SignUpController controllerSignUp = Get.put(SignUpController());
  SettingController _settingController = Get.put(SettingController());
  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Constant.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 130.h,
              width: double.infinity,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Constant.primaryColor,
                      Constant.secondaryColor,
                    ],
                  )),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap:(){
                        Get.back();
              },
                      child: Container(
                        child: Image.asset(AppAssets.backArrowPic, color:Constant.blueLightText,height: 45.h,width: 45.h,),
                      ),
                    ),
                    SizedBox(height: 10.sp),
                    Text(
                      "Change Password",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 28.sp,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [
                        0.5,
                        0.5,
                      ],
                      colors: [
                        Constant.secondaryColor,
                        Colors.white,
                      ])),
              child: Container(
                height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.7,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30.h,
                      ),
                      oldPassword(),
                      SizedBox(height: 10.h),
                      newPassword(),
                      SizedBox(height: 8.sp),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.r),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Constant.primaryColor,
                                Constant.secondaryColor,
                              ],
                            )),
                        child: AppButton(
                          fontFamily: "Quicksand",
                          minBtnHeight: 60.h,
                          borderRadius: 25.r,
                          maxBtnHeight: 60.h,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          text: 'Update',
                          onClick: () {
                            FocusScope.of(context).unfocus();
                            _settingController.changePassword(
                                _settingController.oldPassword.text,
                                _settingController.newPassword.text);
                          },
                          color: Colors.transparent,
                          textColor: Constant.backgroundColor,
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.sp,),
            Container(
                width: Get.width,
                child: NewBannerAdd()),
          ],
        ),
      ),
    );
  }
}
