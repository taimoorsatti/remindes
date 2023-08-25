import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/widget/bottomsheet.dart';

import '../../../../controllers/newevent/newevent_controller.dart';
import '../../../../utils/constants.dart';
import '../../../../widget/app_text_field.dart';
import '../../../../widget/date_time_dialog.dart';

class titleTextField extends StatelessWidget {
  final String? name;

  titleTextField({this.name});

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: Get.find<NewEventController>().titleController,
      hint: name ?? "",
      titleStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.secondaryColor,
      ),
      title: "Title",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}

class dateTextField extends StatelessWidget {
  dateTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      controller: Get.find<NewEventController>().dateController,
      title: "Date",
      anbale: false,
      readOnly: true,
      hint: "20 May, 2023",
      titleStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.secondaryColor,
      ),
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return DateTimeDialog();
            });
      },
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}

class reminderTextField extends StatelessWidget {
  reminderTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      title: "Reminder",
      controller: Get.find<NewEventController>().reminderController,
      readOnly: true,
      hint: "0 Days advance",
      titleStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.secondaryColor,
      ),
      onTap: () {
        reminderBottomSheet(context);
      },
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }

  void reminderBottomSheet(BuildContext context) {
    int _selectGender = -1;
    int _selectExamType = -1;
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return StatefulBuilder(
            builder: (context, setState) {
              return Obx(
                () => Container(
                  height: 300.0.h,
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          topRight: Radius.circular(10.r))),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.sp),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Icon(
                                  Icons.cancel_outlined,
                                  size: 24.sp,
                                  color: Colors.grey,
                                )),
                            Text(
                              "Select",
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Quicksand",
                                color: Colors.grey,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                "Done",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand",
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: Get.find<NewEventController>()
                                        .remindes
                                        .value >
                                    5
                                ? 5
                                : Get.find<NewEventController>()
                                        .remindes
                                        .value +
                                    1,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                     EdgeInsets.only(top: 8.0.sp,right: 15.0.sp,bottom: 8.sp),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                    Get.find<NewEventController>()
                                        .reminderController
                                        .text = "${index} days advance";
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 50.h,
                                        width: 50.w,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.withOpacity(0.2),
                                          borderRadius:
                                              BorderRadius.circular(15.sp),
                                        ),
                                        child: Center(
                                          child: Text(
                                            (index).toString(),
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Quicksand",
                                              color: Constant.primaryColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}

class noteTextField extends StatelessWidget {
  noteTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTextField(
      title: "Note (optional)",
      controller: Get.find<NewEventController>().noteController,
      hint: "write a note...",
      titleStyle: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.secondaryColor,
      ),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }
}

class contactTextField extends StatelessWidget {
  contactTextField({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext c) {
    return Obx(
      () => AppTextFieldSocial(
        controller: Get.find<NewEventController>().socialController.value,
        title:
            "Their ${Get.find<NewEventController>().socialText.value} (optional)",
        readOnly: false,
        hint: Get.find<NewEventController>().hintText.value,
        titleStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          fontFamily: "Quicksand",
          color: Constant.secondaryColor,
        ),
        prefixIcon: Image.asset(
          Get.find<NewEventController>().preFixIcon.value,
          height: 30,
          width: 30,
        ),
        textInputType: Get.find<NewEventController>().socialText.value ==
                    "Phone number" ||
                Get.find<NewEventController>().socialText.value == "Whatsapp"
            ? TextInputType.number
            : TextInputType.text,
        textInputAction: TextInputAction.next,
        onTap: () {},
        onTapperfix: () {
          socialBottomSheet(Get.context!);
        },
        //validator: RequiredValidator(errorText: 'Please Enter your email'),
      ),
    );
  }

  socialBottomSheet(BuildContext context) {
    commonBottomSheet(
      context,
      sheetHeight: 300.h,
      widget: Container(
        height: 300.h,
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<NewEventController>().socialText.value =
                          "Facebook";
                      Get.find<NewEventController>().hintText.value =
                          "Add facebook";
                      Get.find<NewEventController>().preFixIcon.value =
                          AppAssets.facebookIcon;
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.0.sp),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        padding: EdgeInsets.only(
                            left: 10.sp, right: 10.sp, top: 18.sp, bottom: 18.sp),
                        child: Center(
                          child: Text(
                            'Facebook',
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
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<NewEventController>().socialText.value =
                          "Phone number";
                      Get.find<NewEventController>().hintText.value =
                          " add Phone Number";
                      Get.find<NewEventController>().preFixIcon.value =
                          AppAssets.phoneIcon;
                      Navigator.pop(context);
                     FocusScope.of(context).unfocus();
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.0.sp),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            'Phone number',
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
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<NewEventController>().socialText.value =
                          "Instagram";
                      Get.find<NewEventController>().hintText.value =
                          " add instagram";
                      Get.find<NewEventController>().preFixIcon.value =
                          AppAssets.instIcon;
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.0.sp),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            Get.find<NewEventController>().socialText.value =
                                "Instagram",
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
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                  InkWell(
                    onTap: () {
                      Get.find<NewEventController>().socialText.value =
                          "Whatsapp";
                      Get.find<NewEventController>().hintText.value =
                          "add WhatsApp";
                      Get.find<NewEventController>().preFixIcon.value =
                          AppAssets.whatsIcon;
                      FocusScope.of(context).unfocus();
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding:  EdgeInsets.symmetric(vertical: 5.0.sp),
                      child: Container(
                        color: Colors.grey.withOpacity(0.1),
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 18, bottom: 18),
                        child: Center(
                          child: Text(
                            Get.find<NewEventController>().socialText.value =
                                "Whatsapp",
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
                  ),
                  const Divider(
                    thickness: 1,
                    height: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    // showModalBottomSheet(
    //     context: context,
    //     builder: (builder) {
    //        return Container(
    //         height: 300.0.h,
    //         decoration: const BoxDecoration(
    //             color: Colors.white,
    //             borderRadius: BorderRadius.only(
    //                 topLeft: Radius.circular(30),
    //                 topRight: Radius.circular(30))),
    //         child: Column(
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //
    //             InkWell(
    //               onTap: () {
    //                 Get.find<NewEventController>().socialText.value="Facebook";
    //                 Get.find<NewEventController>().socialController.value.text="Facebook";
    //                 Get.find<NewEventController>().preFixIcon.value= AppAssets.whatsIcon;
    //                 Navigator.pop(context);
    //               },
    //
    //               child: Container(
    //                 padding:  EdgeInsets.only(
    //                     left: 10.sp, right: 10.sp, top: 18.sp, bottom: 18.sp),
    //                 child: Center(
    //                   child: Text('FaceBook',
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.w600,
    //                       fontFamily: "Quicksand",
    //                       color: Constant.primaryColor,
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             const Divider(
    //               thickness: 1,
    //               height: 1,
    //             ),
    //             InkWell(
    //               onTap: () {
    //                 Get.find<NewEventController>().socialText.value="Phone Number";
    //                 Get.find<NewEventController>().socialController.value.text="Phone Number";
    //                 Get.find<NewEventController>().preFixIcon.value= AppAssets.phoneIcon;
    //                 Navigator.pop(context);
    //
    //               },
    //               child: Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 10, right: 10, top: 18, bottom: 18),
    //                 child: Center(
    //                   child: Text('Phone Number',
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.w600,
    //                       fontFamily: "Quicksand",
    //                       color: Constant.primaryColor,
    //                     ),),
    //                 ),
    //               ),
    //             ),
    //             const Divider(
    //               thickness: 1,
    //               height: 1,
    //             ),
    //             InkWell(
    //               onTap: () {
    //
    //                 Get.find<NewEventController>().socialText.value="Instgram";
    //                 Get.find<NewEventController>().socialController.value.text="Instgram";
    //                 Get.find<NewEventController>().preFixIcon.value= AppAssets.facebookIcon;
    //                 Navigator.pop(context);
    //
    //               },
    //               child: Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 10, right: 10, top: 18, bottom: 18),
    //                 child: Center(
    //                   child: Text(Get.find<NewEventController>().socialText.value="Instgram",
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.w600,
    //                       fontFamily: "Quicksand",
    //                       color: Constant.primaryColor,
    //                     ),),
    //                 ),
    //               ),
    //             ),
    //             const Divider(
    //               thickness: 1,
    //               height: 1,
    //             ),
    //             InkWell(
    //               onTap: () {
    //
    //                 Get.find<NewEventController>().socialText.value="WhatsApp";
    //                 Get.find<NewEventController>().socialController.value.text="WhatsApp";
    //                 Get.find<NewEventController>().preFixIcon.value= AppAssets.instaIcon;
    //                 Navigator.pop(context);
    //               },
    //               child: Container(
    //                 padding: const EdgeInsets.only(
    //                     left: 10, right: 10, top: 18, bottom: 18),
    //                 child: Center(
    //                   child: Text(Get.find<NewEventController>().socialText.value="WhatsApp",
    //                     style: TextStyle(
    //                       fontSize: 18.sp,
    //                       fontWeight: FontWeight.w600,
    //                       fontFamily: "Quicksand",
    //                       color: Constant.primaryColor,
    //                     ),),
    //                 ),
    //               ),
    //             ),
    //           ],
    //         ),
    //       );
    //     }
    //     );
  }
}
