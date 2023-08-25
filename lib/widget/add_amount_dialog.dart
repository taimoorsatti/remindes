import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/signin/signin_controller.dart';

import '../utils/constants.dart';

class showForgetPasswordDialog extends StatefulWidget {
  String? onClick;

  showForgetPasswordDialog({this.onClick});

  @override
  State<showForgetPasswordDialog> createState() =>
      _showForgetPasswordDialogState();
}

class _showForgetPasswordDialogState extends State<showForgetPasswordDialog> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Get.find<SignInController>().restpasswordController;
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
              height: MediaQuery.of(context).size.height * 0.2,
              width: MediaQuery.of(context).size.width * 0.7,
              padding:  EdgeInsets.only(left: 15.sp, right: 15.sp, top: 15.sp),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          "Enter Your Email",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Quicksand"),
                        ),
                        SizedBox(height: 15.sp,),
                        Container(
                          padding:  EdgeInsets.only(
                            left: 8.sp,
                            right: 8.sp,
                            bottom: 5.sp,
                          ),
                          height: 45.sp,
                          decoration: BoxDecoration(
                            color: const Color(0XFFF2F2F4),
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: Opacity(
                            opacity: 0.64,
                            child: TextField(
                              controller: Get.find<SignInController>().restpasswordController,
                              style:
                                  Theme.of(context).textTheme.caption?.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp,
                                    fontFamily: "Quicksand",
                                        color: Constant.primaryColor,
                                      ),
                              //keyboardType: ,
                              decoration: InputDecoration(
                                focusColor: Colors.green,
                                border: InputBorder.none,
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.5),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Quicksand"),
                                fillColor: Colors.red,
                              ),
                              //onChanged: widget.onChanged,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.all(15.0.sp),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap:(){
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  color: Constant.primaryColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Quicksand"),
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              if(Get.find<SignInController>().restpasswordController.text.isEmail) {
                                Get.find<SignInController>().resetPassword();
                                Navigator.pop(context);
                              }
                                else {
                                  Fluttertoast.showToast(msg: "invalid Email");

                              }



                            },
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                  color: Constant.primaryColor,
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Quicksand"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
