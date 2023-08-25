import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/signin/signin_controller.dart';

import '../screens/setting/components/privacy_policy/privacy_policy_view.dart';
import '../utils/constants.dart';
import 'app_button.dart';

class TermsPolicy extends StatefulWidget {
  String? onClick;

  TermsPolicy({this.onClick});

  @override
  State<TermsPolicy> createState() =>
      _TermsPolicyState();
}

class _TermsPolicyState extends State<TermsPolicy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Get
    //     .find<SignInController>()
    //     .restpasswordController;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      child: Stack(
        children: [
          Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Container(
             height: 300.h,
              width: Get.width-40,
              padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 10.sp),
              child: Stack(
                children: [
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: const Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.cancel_outlined)),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                          text: 'Privacy Policy',
                          onClick: () {
                            FocusScope.of(context).unfocus();
                            Get.to(PrivacyPolicyScreen());
                          },
                          color: Colors.transparent,
                          textColor: Constant.backgroundColor,
                        ),
                      ),
                      SizedBox(height: 25.sp),
                      Container(height: 1,color: Constant.colorBorder,),
                      SizedBox(height: 25.sp),
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
                          text: 'Terms Of use',
                          onClick: () {
                            FocusScope.of(context).unfocus();
                            Get.to(TermsUse());


                          },
                          color: Colors.transparent,
                          textColor: Constant.backgroundColor,
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
