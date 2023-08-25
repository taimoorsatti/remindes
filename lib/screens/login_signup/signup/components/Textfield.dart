import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/signup/signup_controller.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../../utils/constants.dart';
import '../../../../widget/app_text_field.dart';

class SignUpEmailTextField extends StatelessWidget {

  SignUpEmailTextField({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return  AppTextField(
      controller: Get.find<SignUpController>().emailController,
      hint: "example@gmail.com",
      title: "Email",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}



class SignUpNameTextField extends StatelessWidget {
  SignUpNameTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   AppTextField(
      hint: "name",
     controller: Get.find<SignUpController>().nameController,
      title: "Name",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}



class SignUppasswordTextField extends StatefulWidget {
  SignUppasswordTextField({Key? key}) : super(key: key);

  @override
  State<SignUppasswordTextField> createState() => _SignUppasswordTextFieldState();
}

class _SignUppasswordTextFieldState extends State<SignUppasswordTextField> {
  bool isShow=true;
  @override
  Widget build(BuildContext context) {

    return  AppTextField(
      title: "Password",
      controller: Get.find<SignUpController>().passwordController,
      isObscure: isShow,
      hint: "at least 8 character",
      textInputType: TextInputType.text
      ,
      textInputAction: TextInputAction.next,
      suffixIcon: InkWell(
        onTap: () {
          setState(() {
            isShow =
            isShow == false
                ? true
                : false;
          });
        },
        child:
        Icon(
          isShow == false
              ? Icons.visibility
              : Icons.visibility_off,
          color: Constant.primaryColor,
        ),
      ),
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}