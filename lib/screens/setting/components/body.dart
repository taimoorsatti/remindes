import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/screens/setting/components/privacy_policy/privacy_policy_view.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/global.dart';

import '../../../controllers/setting/setting_controller.dart';
import '../../../controllers/signin/signin_controller.dart';
import '../../../utils/constants.dart';
import 'changepassword/changepassword.dart';
import 'editprofile/editprofile.dart';

class SettingBody extends StatefulWidget {
   SettingBody({Key? key}) : super(key: key);

  @override
  State<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends State<SettingBody> {
  SettingController controllerSetting=Get.put(SettingController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement initState
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    return Obx(
      ()=>
       Column(
       crossAxisAlignment: CrossAxisAlignment.start,
       children: [
         SizedBox(height: 80.sp,),
       Padding(
         padding:  EdgeInsets.symmetric(horizontal: 20.0.sp,),
         child: GradientText(
         "Settings",
         style:  TextStyle(
           fontSize: 28.sp,
           fontWeight: FontWeight.bold,
           fontFamily: "Quicksand",
           color: Constant.primaryColor,
         ),
           gradient:LinearGradient(
             begin: Alignment.topCenter,
             end: Alignment.bottomCenter,
             colors: [
               Constant.primaryColor,
               Constant.secondaryColor,
             ],
           ),


),
       ),
         SizedBox(height: 35.h,),
         Expanded(
           child:
               controllerSetting.isLoading.value==true?

             Center(child: Container(),)
           :
           ListView.builder(
               itemCount:controllerSetting.listSettingModel.length ,
               itemBuilder:(BuildContext context,int index){
                 return Padding(
                   padding:  EdgeInsets.symmetric(horizontal: 20.0.sp,),
                   child: Container(
                     child: InkWell(
                       onTap: (){
                        Get.find<SettingController>().switchPage(index: index,context: context);
                       },
                       child: Column(
                         children: [
                           Padding(
                             padding: EdgeInsets.only(top:20.sp),
                             child: Row(
                               children: [
                                 Image.asset(controllerSetting.listSettingModel[index].imageUrl??"",height: 20.h,width: 20.w,),
                                 SizedBox(width: 10.w,),
                                 Text(controllerSetting.listSettingModel[index].name??"",style: TextStyle(
                                   fontSize: 14.sp,
                                   fontWeight: FontWeight.w700,
                                   fontFamily: "Quicksand",
                                 ),),
                               ],
                             ),
                           ),

                           Padding(
                             padding:  EdgeInsets.only(top: 20.0.sp,right: 5.sp,left: 5.sp),
                             child: Container(
                               height: 1,
                               width: double.infinity,
                               color: Constant.primaryColor.withOpacity(0.3),
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                 );

               } ),
         ),
         SizedBox(height: 10.sp,),
         Padding(
           padding: EdgeInsets.only(bottom: 8.0.sp),
           child: Container(
               width: Get.width,
               child: NewBannerAdd()),
         ),
       ],
          ),
    );

  }
}
