import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/screens/login_signup/login/components/Textfield.dart';
import 'package:remindly_app/screens/login_signup/signup/components/Textfield.dart';
import 'package:remindly_app/screens/setting/components/privacy_policy/privacy_policy_view.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/widget/terms_policy.dart';

import '../../../../controllers/signup/signup_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/app_button.dart';
import '../../login/login_view.dart';


class SignUpBody extends StatefulWidget {
  SignUpBody({Key? key}) : super(key: key);

  @override
  State<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends State<SignUpBody> {
  SignUpController controllerSignUp = Get.put(SignUpController());



  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          color: Constant.secondaryColor,
          child: Column(
            children: [
              Container(
                height: 150.h,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Constant.primaryColor,
                    Constant.secondaryColor,
                  ],
                )),
                child: Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.sp,
                        letterSpacing: 1.0,
                        fontFamily: "Quicksand",
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                color: Constant.secondaryColor,
                child: Container(
                  height: 480.h,
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      Container(
                        height: 480.h,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                          color: Constant.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(15),
                            topLeft: Radius.circular(15),
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  EdgeInsets.symmetric(horizontal: 15.0.sp),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30.h),
                                  SignUpNameTextField(),
                                  SizedBox(height: 30.h),
                                  SignUpEmailTextField(),
                                  SizedBox(height: 30.h),
                                  SignUppasswordTextField(),
                                  SizedBox(
                                    height: 10.sp,
                                  ),
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          print("ciujh");
                                        setState(() {
                                          controllerSignUp.checkBoxValue= controllerSignUp.checkBoxValue?false:true;
                                        });

                                        },
                                        child:controllerSignUp.checkBoxValue? Image.asset(
                                          AppAssets.check,
                                          height: 25.h,
                                          width: 25.w,
                                        ):InkWell(
                                          onTap: (){
                                            print("ciujh");
                                            setState(() {
                                              controllerSignUp.checkBoxValue= controllerSignUp.checkBoxValue?false:true;
                                            });
                                          },
                                          child: Image.asset(
                                            AppAssets.uncheck,
                                            height: 25.h,
                                            width: 25.w,
                                          ),
                                        )
                                      ),
                                      SizedBox(width: 10.sp,),
                                      Text(
                                        'I accept the ',
                                        style: TextStyle(
                                            color: Constant.primaryColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Quicksand"),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          Get.to(
                                              TermsUse());
                                        },
                                        child: Text('terms of use',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Quicksand",
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                      ),
                                      Text(' and ',
                                          style: TextStyle(
                                              color:
                                                  Constant.primaryColor)),
                                      InkWell(
                                        onTap: (){
                                          Navigator.pushNamed(context,
                                              PrivacyPolicyScreen.routeName);
                                        },
                                        child: Text('Privacy Policy',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "Quicksand",
                                              decoration:
                                                  TextDecoration.underline,
                                            )),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 60.h,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Constant.primaryColor,
                Constant.secondaryColor,
              ],
            ),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r),
              topRight: Radius.circular(10.r),
            ),
          ),
          alignment: Alignment.bottomCenter,
          height: 130.h,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppButton(
                  fontFamily: "Quicksand",
                  minBtnHeight: 60.h,
                  borderRadius: 25.r,
                  maxBtnHeight: 60.h,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  text: 'Signup',
                  onClick: () {
                    FocusScope.of(context).unfocus();
                    controllerSignUp.validateEmail(
                      email: controllerSignUp.emailController.text.trim(),
                      password: controllerSignUp.passwordController.text.trim(),
                      name: controllerSignUp.nameController.text.trim(),
                    );
                  },
                  color: Colors.white,
                  textColor: Constant.primaryColor,
                ),
                SizedBox(
                  height: 10.sp,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, LoginViewScreen.routeName);
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'already have an account ?',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Quicksand"),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' Login',
                            style: TextStyle(
                                color: Constant.backgroundColor,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Quicksand")),
                        TextSpan(
                            text: ' here',
                            style: TextStyle(
                                color: Constant.backgroundColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand")),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
