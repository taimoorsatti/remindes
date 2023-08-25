import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/signin/signin_controller.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../../widget/app_text_field.dart';

class EmailTextField extends StatelessWidget {
  EmailTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: Get.find<SignInController>().emailLoginController,
      hint: "example@gmail.com",
      title: "Email",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}

class passwordTextField extends StatefulWidget {
  passwordTextField({Key? key}) : super(key: key);

  @override
  State<passwordTextField> createState() => _passwordTextFieldState();
}

class _passwordTextFieldState extends State<passwordTextField> {
  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: Get.find<SignInController>().passwordLoginController,
      isObscure: Get.find<SignInController>().isShowPassword,
      title: "Password",
      hint: "",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      suffixIcon: InkWell(
        onTap: () {
          setState(() {
            Get.find<SignInController>().isShowPassword =
                Get.find<SignInController>().isShowPassword == false
                    ? true
                    : false;
          });
        },
            child:
                Icon(
                Get.find<SignInController>().isShowPassword == false
                    ? Icons.visibility
                    : Icons.visibility_off,
                      color: Constant.primaryColor,
                ),
      ),
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}
