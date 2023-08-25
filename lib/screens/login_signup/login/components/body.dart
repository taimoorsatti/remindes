import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/controllers/signin/signin_controller.dart';
import 'package:remindly_app/screens/login_signup/login/components/Textfield.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/widget/add_amount_dialog.dart';

import '../../../../controllers/signup/signup_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/app_button.dart';
import '../../../event/event_view.dart';
import '../../signup/signup_view.dart';

class LoginBody extends StatelessWidget {
  LoginBody({Key? key}) : super(key: key);
  SignUpController controllerSignUp = Get.put(SignUpController());


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
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
                "Login",
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
            height: MediaQuery.of(context).size.height * 0.76,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Constant.secondaryColor,
                Constant.secondaryColor,
              ],
            )),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.76,
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
                    EmailTextField(),
                    SizedBox(height: 10.h),
                    passwordTextField(),
                    SizedBox(height: 8.sp),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return showForgetPasswordDialog();
                                });
                          },
                          child: Text(
                            "Forget Password?",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Constant.profileLightText,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Quicksand"),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40.h,
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
                        text: 'Login',
                        onClick: () {
                          FocusScope.of(context).unfocus();

                        // Get.to(EventScreen());
                          Get.find<SignInController>().validateEmail(email:  Get.find<SignInController>().emailLoginController.text.trim(), password:Get.find<SignInController>().passwordLoginController.text.trim());
                        },
                        color: Colors.transparent,
                        textColor: Constant.backgroundColor,
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(SignUpView());
                      },
                      child: RichText(
                        text: TextSpan(
                          text: 'Don,t have an account yet ?',
                          style: TextStyle(
                              color: Constant.secondaryColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Quicksand"),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Register',
                                style: TextStyle(
                                    color: Constant.secondaryColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand")),
                            TextSpan(
                                text: ' here',
                                style: TextStyle(
                                    color: Constant.primaryColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Quicksand")),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                          Text(
                          "Or login as a ",
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: Constant.blueLightText,
                            fontWeight: FontWeight.w400,
                            fontFamily: "Quicksand",
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            controllerSignUp.anonymousSignIn();
                          },
                          child: Text(
                            "Guest User",
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Constant.primaryColor,
                              fontFamily: "Quicksand",
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
