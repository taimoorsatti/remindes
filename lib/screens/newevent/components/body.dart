import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/controllers/newevent/newevent_controller.dart';
import 'package:remindly_app/models/event/upcoming/upcoming_model.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/screens/newevent/components/textfield/new_event_textfield.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:remindly_app/screens/setting/components/subscription/subscription_view.dart';

import '../../../services/ads/app_open_manager.dart';
import '../../../utils/assets_image_path.dart';
import '../../../utils/constants.dart';
import '../../../utils/global.dart';
import '../../../widget/app_button.dart';

class NewEventBody extends StatefulWidget {
  final String eventName;
  final String btnText;

  const NewEventBody({
    required this.eventName,
    required this.btnText,
  });

  @override
  State<NewEventBody> createState() => _NewEventBodyState();
}

class _NewEventBodyState extends State<NewEventBody> {
  @override
  bool isToggled = false;
  bool isLoading = false;
  NewEventController controllerNewEvent = Get.put(NewEventController());

  // Option 2// Option 2
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Stack(
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          child: Image.asset(
                            AppAssets.backArrowPic,
                            color: Color(0xff36308b),
                            height: 40.h,
                            width: 40.h,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GradientText(
                            widget.eventName,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontFamily: "Quicksand",
                              color: Constant.primaryColor,
                            ),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Constant.primaryColor,
                                Constant.secondaryColor,
                              ],
                            ),
                          ),
                          widget.btnText == "Save"
                              ? Container()
                              : InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection("events")
                                        .doc(FirebaseAuth.instance.currentUser?.uid)
                                        .collection("userEvents")
                                        .doc(controllerNewEvent.doccumentId)
                                        .delete();
                                    controllerNewEvent.fetchAllDat();
                                    AdsApp.createInterstitialAd();
                                    Fluttertoast.showToast(
                                        msg: "  event deleted Successfully  ");
                                    Get.toNamed(EventScreen.routeName);
                                  },
                                  child: Icon(
                                    Icons.delete_outline,
                                    color: Constant.primaryColor,
                                    size: 40.sp,
                                  ),
                                ),
                        ],
                      ),
                      SizedBox(
                        height: 25.h,
                      ),
                      titleTextField(name: widget.eventName),
                      SizedBox(
                        height: 20.h,
                      ),
                      dateTextField(),
                      SizedBox(
                        height: 20.h,
                      ),
                      reminderTextField(),
                      SizedBox(
                        height: 20.h,
                      ),
                      noteTextField(),
                      SizedBox(
                        height: 20.h,
                      ),
                      contactTextField(),
                      SizedBox(
                        height: 15.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Repeat every",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          InkWell(
                            onTap: () {
                              genderModalBottomSheetMenu(context);
                            },
                            child: Row(
                              children: [
                                Obx(() => Text(
                                      controllerNewEvent.selectedText.value,
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Quicksand",
                                        color: Constant.secondaryColor,
                                      ),
                                    )),
                                SizedBox(
                                  width: 2.w,
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  color: Constant.secondaryColor,
                                  size: 30.sp,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          FlutterSwitch(
                            height: 25.0,
                            width: 45.0,
                            padding: 4.0,
                            toggleSize: 20.0,
                            inactiveColor: Constant.colorTextFieldeBorder,
                            borderRadius: 15.0,
                            activeColor: Constant.primaryColor,
                            value: controllerNewEvent.isRepeat,
                            onToggle: (value) {
                              setState(() {
                                isToggled = value;
                                controllerNewEvent.isRepeat = value;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5.sp,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "For SMS and CALL reminders please",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Colors.black54,
                            ),
                          ),
                          SizedBox(
                            width: 5.sp,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(SubsriptionScreen.routeName);
                            },
                            child: Text(
                              "Subscribe",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Quicksand",
                                color: Constant.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                      AppButton(
                        fontFamily: "Quicksand",
                        minBtnHeight: 60.h,
                        borderRadius: 15.r,
                        maxBtnHeight: 60.h,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        text: widget.btnText,
                        onClick: () {
                          FocusScope.of(context).unfocus();
                          // controllerNewEvent.saveNotification(
                          //     catName: widget.eventName,
                          //     dateTimeVal:
                          //     "${controllerNewEvent.myWeekDays[controllerNewEvent.selectedDate.weekday - 1]}, ${controllerNewEvent.selectedDate.day.toString().padLeft(2, '0')} ${controllerNewEvent.myMonths[controllerNewEvent.selectedDate.month - 1]},${controllerNewEvent.selectedTime.hourOfPeriod} : ${controllerNewEvent.selectedTime.minute} ${controllerNewEvent.selectedTime.period == DayPeriod.am ? 'AM' : 'PM'}",
                          //     isFav: false
                          // );
                          isLoading=true;
                          Future.delayed(const Duration(milliseconds: 1000), () {
                           setState(() {
                             isLoading=false;
                           });
                          });

                          controllerNewEvent.formValidation(
                              widget.btnText, widget.eventName);
                        },
                        color: Constant.secondaryColor,
                        textColor: Constant.backgroundColor,
                      ),
                      SizedBox(
                        height: 20.sp,
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
        isLoading?Center(
          child:Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp),
        ):Container(),
      ],
    );
  }

  void genderModalBottomSheetMenu(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Container(
                height: 300.0.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        setState(() {
                          controllerNewEvent.selectedText.value = "Today";
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            'Today',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Constant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          controllerNewEvent.selectedText.value = "Monthly";
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            'Monthly',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Constant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          controllerNewEvent.selectedText.value = "Weekly";
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            'Weekly',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Constant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      height: 1,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          controllerNewEvent.selectedText.value = "Yearly";
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                        });
                      },
                      child: Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            'Yearly',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Quicksand",
                              color: Constant.primaryColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}
