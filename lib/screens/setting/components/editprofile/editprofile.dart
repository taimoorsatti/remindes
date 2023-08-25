import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:remindly_app/controllers/setting/setting_controller.dart';
import 'package:remindly_app/screens/login_signup/login/components/Textfield.dart';
import 'package:remindly_app/screens/login_signup/login/login_view.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../../controllers/checkinternet/checkinternet_controller.dart';
import '../../../../controllers/signup/signup_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../utils/global.dart';
import '../../../../widget/app_button.dart';
import '../../../event/event_view.dart';
import '../../../login_signup/signup/components/Textfield.dart';
import 'componets/textfield.dart';

class EditProfileScreen extends StatefulWidget {
  static const routeName="/editprofile";
  EditProfileScreen({Key? key}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  SignUpController controllerSignUp = Get.put(SignUpController());

  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  SettingController settingController = Get.put(SettingController());
@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    settingController.updateUser();
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Constant.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
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
                    SizedBox(height: 15.sp),
                    Text(
                      "Edit Profile",
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
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          EditEmailTextField(),
                          SizedBox(height: 10.h),
                          EditNameTextFeild(),
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
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              text: 'Update',
                              onClick: () async{
                                FocusScope.of(context).unfocus();
                              await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                     "name":settingController.nameController.value.text,
                                  "email":settingController.emailController.value.text,
                                });
                                Fluttertoast.showToast(msg: "Update Successfully!");
                              },
                              color: Colors.transparent,
                              textColor: Constant.backgroundColor,
                            ),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                                ),
                            child: AppButton(
                              fontFamily: "Quicksand",
                              minBtnHeight: 60.h,
                              borderRadius: 25.r,
                              maxBtnHeight: 60.h,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              text: 'Delete Account',
                              onClick: () async{
                                FocusScope.of(context).unfocus();
                                await FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .update({
                                  "isDeleted":true,
                                });
                                Get.to(LoginViewScreen());
                              },
                              color: Colors.white,
                              textColor: Constant.primaryColor,
                            ),
                          ),
                          SizedBox(height: 10.sp,),

                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Container(
                width: Get.width,
                child: NewBannerAdd()),
          ],
        ),
      ),
    );
  }
}


