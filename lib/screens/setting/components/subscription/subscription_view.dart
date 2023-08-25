

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../controllers/checkinternet/checkinternet_controller.dart';
import '../../../../utils/assets_image_path.dart';
import '../../../../utils/constants.dart';
import 'components/call.dart';
import 'components/sms.dart';

class SubsriptionScreen extends StatelessWidget {
  static const routeName="/subcription";
   SubsriptionScreen({Key? key}) : super(key: key);
   CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 25.sp,horizontal: 15.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Container(
                  child: Image.asset(AppAssets.backArrowPic, color: Color(0xff36308b),height: 50.h,width: 50.h,),
                ),
              ),
              SizedBox(height: 20.sp,),
              Text("Remindes Packages", style:  TextStyle(
                fontSize: 28.sp,
                fontWeight: FontWeight.bold,
                fontFamily: "Quicksand",
                color: Constant.primaryColor,
              ),),
              SizedBox(height: 20.sp,),
              SMS(),
              SizedBox(height: 20.sp,),
              CallScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

