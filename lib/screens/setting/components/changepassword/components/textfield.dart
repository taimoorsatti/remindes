import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/setting/setting_controller.dart';
import 'package:remindly_app/controllers/signup/signup_controller.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../../../utils/constants.dart';
import '../../../../../widget/app_text_field.dart';



class oldPassword extends StatelessWidget {

  oldPassword({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  AppTextField(
      controller: Get.find<SettingController>().oldPassword,
      hint: "",
      title: "Old Password",
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight:FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.primaryColor,
      ),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}



class newPassword extends StatelessWidget {
  newPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   AppTextField(
      hint: "",
      titleStyle: const TextStyle(
        fontSize: 16,
        fontWeight:FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.primaryColor,
      ),
      controller: Get.find<SettingController>().newPassword,
      title: "New Password",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}



class SignUppasswordTextField extends StatelessWidget {
  SignUppasswordTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return  AppTextField(
      title: "Password",
      controller: Get.find<SignUpController>().passwordController,
      hint: "at least 8 character",
      textInputType: TextInputType.text
      ,
      textInputAction: TextInputAction.next,
      suffixIcon:Image.asset(AppAssets.viewPic,height: 20.h,width: 20.w,),
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}
