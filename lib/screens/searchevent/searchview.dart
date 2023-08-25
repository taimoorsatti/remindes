import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/controllers/searchevent/searchevent_controller.dart';
import 'package:remindly_app/screens/newevent/new_event_view.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../controllers/newevent/newevent_controller.dart';
import '../../utils/constants.dart';
import '../../utils/global.dart';

class SearchView extends StatefulWidget {
  static const routeName = "/search";

  SearchView({Key? key}) : super(key: key);

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  NewEventController _searchEventController = Get.put(NewEventController());
  CheckConnectionStream checkConnectionStream =
      Get.put(CheckConnectionStream());

  TextEditingController controller = TextEditingController();

  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor:Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: GetBuilder(
          init: SearchEventController(),
          builder: (SearchEventController viewModel) {
            return SafeArea(
              child: Obx(
                () => Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 10.sp),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Padding(
                            padding: EdgeInsets.only(top: 8.0.sp),
                            child: Image.asset(
                              AppAssets.backArrowPic,
                              height: 45.sp,
                              width: 45.sp,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        GradientText(
                          "All Events!",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                            color: Constant.primaryColor,
                          ), gradient:LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Constant.primaryColor,
                            Constant.secondaryColor,
                          ],
                        ),
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Row(
                          children: [
                            Flexible(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(right: 10.sp),
                                padding: EdgeInsets.only(
                                  left: 8.sp,
                                  right: 8.sp,
                                  bottom: 0,
                                ),
                                height: 40.sp,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Opacity(
                                  opacity: 0.8,
                                  child: TextField(
                                    controller: controller,
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14.sp,
                                          fontFamily: "Quicksand",
                                          color: Constant.primaryColor,
                                        ),
                                    //keyboardType: ,
                                    decoration: InputDecoration(
                                      focusColor: Colors.green,
                                      border: InputBorder.none,
                                      hintText: "Search by name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.withOpacity(0.5),
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Quicksand"),
                                      fillColor: Colors.red,
                                    ),
                                    onChanged: (value) {
                                      setState(() {
                                        viewModel.getSearchEvent(value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                controller.text = '';
                                viewModel.getSearchEvent("");
                              },
                              child: Padding(
                                padding: EdgeInsets.all(8.0.sp),
                                child: Text(
                                  "Cancel",
                                  style: TextStyle(
                                      color: Colors.grey.withOpacity(0.5),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Quicksand"),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 3.sp,
                        ),
                        Container(
                          height: 1,
                          color: Colors.grey.withOpacity(0.3),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        viewModel.Loading==true?
                          Center(child: Column(
                            children: [
                              SizedBox(height: 150.h,),
                              Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp),
                            ],
                          )):

                        viewModel.checckEventList.length == 0
                            ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Column(
                                children: [
                                  SizedBox(height: 150.sp,),
                                  Image.asset(
                                    AppAssets.noEventIcon,
                                    height: 150.h,
                                    width: 150.w,
                                    color: Constant.primaryColor
                                        .withOpacity(0.7),
                                  ),
                                  SizedBox(
                                    height: 20.sp,
                                  ),
                                  Text(
                                    "No events yet",
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Constant.secondaryColor,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50.sp,
                                  ),
                                ],
                              ),
                            )
                            : ListView.builder(
                                shrinkWrap: true,
                                physics:NeverScrollableScrollPhysics(),
                                itemCount: viewModel.searchEventList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return viewModel.searchEventList.length == 0
                                      ? Text(
                                        "Not Found",
                                        style: TextStyle(
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Constant.secondaryColor,
                                      fontFamily: "Quicksand",
                                        ),
                                      )
                                      : SingleChildScrollView(
                                        child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.find<
                                                                NewEventController>()
                                                            .updateEvent(viewModel
                                                                    .searchEventList[
                                                                index]);
                                                        Get.to(NewEventViewScreen(
                                                            btnText: "Update",
                                                            eventName: viewModel
                                                                    .searchEventList[
                                                                        index]
                                                                    .cat ??
                                                                ""));
                                                      },
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Image.asset(
                                                            viewModel
                                                                    .searchEventList[
                                                                        index]
                                                                    .iconUrl ??
                                                                AppAssets.workPic,
                                                            height: 30.sp,
                                                            width: 30.sp,
                                                            color: Constant
                                                                .blueLightText,
                                                          ),
                                                          SizedBox(
                                                            width: 10.sp,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  viewModel
                                                                          .searchEventList[
                                                                              index]
                                                                          .title ??
                                                                      "",
                                                                  style: TextStyle(
                                                                    fontSize: 18.sp,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        "Quicksand",
                                                                    color: Colors
                                                                        .black,
                                                                  )),
                                                              SizedBox(
                                                                height: 10.sp,
                                                              ),
                                                              Text(
                                                                viewModel
                                                                        .searchEventList[
                                                                            index]
                                                                        .date ??
                                                                    "",
                                                                style: TextStyle(
                                                                  fontSize: 14.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontFamily:
                                                                      "Quicksand",
                                                                  color:
                                                                      Colors.black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        Get.dialog(
                                                          Center(
                                                              child: Lottie.asset(
                                                                  'assets/gifs/lottie.json',
                                                                  height: 150.sp,
                                                                  width: 150.sp)),
                                                        );
                                                        FirebaseFirestore.instance
                                                            .collection("events")
                                                            .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                ?.uid)
                                                            .collection(
                                                                "userEvents")
                                                            .doc(viewModel
                                                                .searchEventList[
                                                                    index]
                                                                .eventId)
                                                            .update({
                                                          "isFavorite": viewModel
                                                                      .searchEventList[
                                                                          index]
                                                                      .isfav ==
                                                                  false
                                                              ? true
                                                              : false,
                                                        });
                                                        Navigator.pop(context);
                                                      },
                                                      child: viewModel
                                                                  .searchEventList[
                                                                      index]
                                                                  .isfav ==
                                                              false
                                                          ? Image.asset(
                                                              AppAssets
                                                                  .heartUnSelectedPic,
                                                              height: 30.h,
                                                              width: 30.w,
                                                              color: Colors.red,
                                                            )
                                                          : Image.asset(
                                                              AppAssets
                                                                  .heartSelectedPic,
                                                              height: 30.sp,
                                                              width: 30.sp,
                                                              color: Colors.red,
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 15.sp,
                                                ),
                                                Container(
                                                  height: 1,
                                                  color:
                                                      Colors.grey.withOpacity(0.3),
                                                ),
                                              ],
                                            )),
                                      );
                                },
                              )
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
