import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/screens/newevent/new_event_view.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';
import 'package:remindly_app/utils/global.dart';

import '../../../controllers/addevent/add_event_controller.dart';
import '../../../controllers/newevent/newevent_controller.dart';

class AddEventBody extends StatelessWidget {
   AddEventBody({Key? key}) : super(key: key);
  AddEventController controllerAddEvent =Get.put(AddEventController());
   NewEventController controllernewEvent =Get.put(NewEventController());
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 15.0.sp,vertical: 8.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h,),
          InkWell(
            onTap: (){
              Get.back();
            },
            child: Container(
              child: Image.asset(AppAssets.backArrowPic, color: Color(0xff36308b),height: 40.h,width: 40.h,),
            ),
          ),
          SizedBox(height: 10.h,),
          GradientText(
            "Add Event",
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
          SizedBox(height: 10.h,),
          Expanded(
            child: ListView.builder(
              itemCount: controllerAddEvent.listAddEvent.length,
              itemBuilder: (BuildContext context,int index){
                return Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.sp),
                  child: InkWell(
                    onTap: (){
                      controllernewEvent.clearEvent();
                      Navigator.push(
                        Get.context!,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: NewEventViewScreen(btnText:"Save",eventName:controllerAddEvent.listAddEvent[index].type??""),
                        ),
                      );

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xff36308b),
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Constant.primaryColor,
                                Constant.secondaryColor,
                              ],
                            ),
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Padding(
                        padding:  EdgeInsets.all(15.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                             Text(controllerAddEvent.listAddEvent[index].type??"", style:  TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Constant.backgroundColor,
                            ),),
                            Image.asset(controllerAddEvent.listAddEvent[index].iconUrl??"",height: 60.h,width: 60.w,),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              },

            ),
          ),
        ],
      ),
    );
  }
}
