import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/models/event/upcoming/upcoming_model.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';
import '../../../../controllers/event/upcoming/upcoming_controller.dart';
import '../../../../controllers/newevent/newevent_controller.dart';
import '../../../../utils/global.dart';
import '../../../addevent/add_event_view.dart';
import '../../../newevent/new_event_view.dart';
import '../../../searchevent/searchview.dart';

class UpComingEvent extends StatefulWidget {
  final String? imagePath;
  final String? type;
  final String? date;
  final String? favIcon;

  UpComingEvent({this.date, this.type, this.imagePath, this.favIcon});

  @override
  State<UpComingEvent> createState() => _UpComingEventState();
}

class _UpComingEventState extends State<UpComingEvent> {
  UpComingController upComingController = Get.put(UpComingController());

  NewEventController newEventController = Get.put(NewEventController());


bool seeAll=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   upComingController.isLoading.value=true;



   }

  @override
  Widget build(BuildContext context) {
    upComingController.Notification(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 10.sp),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Upcoming Events",
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Quicksand",
                      color: Constant.primaryColor,
                    ),
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.toNamed(SearchView.routeName);
                        },
                        child:
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quicksand",
                            color: Constant.primaryColor,
                          ),
                        )
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Container(
                height: 115.h,
                child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("events")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection("userEvents")
                        .limit(8)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {

                          upComingController.listUpComing = [];
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          if (dataSnapshot.docs.isNotEmpty) {
                            upComingController.setSeeAllVal(true);

                            for (var doc in dataSnapshot.docs) {
                              var elementDate =
                                  DateFormat("MMM-d-yyyy, " 'h:mm a')
                                      .parse(doc["nextDate"]);
                              upComingController.modelUpComing =
                                  UpcomingModel.fromJson(
                                      doc.data() as Map<String, dynamic>);
                              if (elementDate.isAfter(DateTime.now())) {
                                upComingController.getImageIcon(
                                    upComingController.modelUpComing.cat,
                                    upComingController.modelUpComing);
                                upComingController.listUpComing
                                    .add(upComingController.modelUpComing);
                                upComingController.calennderList
                                    .add(upComingController.modelUpComing);
                                upComingController.list
                                    .add(upComingController.modelUpComing);
                              }
                            }
                            return
                              upComingController.listUpComing.length==0?
                              Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "you have no upcoming yet?",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.sp,
                                    ),
                                    Text(
                                      "Click to add",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Constant.primaryColor,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                  ],
                                ),
                              )
                                  :
                              ListView.builder(
                              shrinkWrap: true,
                              physics: ClampingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: upComingController.listUpComing.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 6.0.sp),
                                  child: InkWell(
                                    onTap: () {
                                      Get.find<NewEventController>().updateEvent(
                                          upComingController.listUpComing[index]);
                                      Get.to(NewEventViewScreen(
                                          btnText: "Update",
                                          eventName: upComingController
                                                  .listUpComing[index].cat ??
                                              ""));
                                    },
                                    child: Container(
                                      width: 150.w,
                                      decoration: BoxDecoration(
                                        color: Constant.secondaryColor,
                                        borderRadius: BorderRadius.circular(24.r),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Constant.secondaryColor,
                                            Constant.primaryColor,

                                          ],
                                        ),
                                      ),
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 8.0.sp,
                                                vertical: 10.0.sp),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Image.asset(
                                                  upComingController
                                                          .listUpComing[index]
                                                          .iconUrl ??
                                                      AppAssets.workPic,
                                                  height: 65.h,
                                                  width: 65.w,
                                                ),
                                                SizedBox(
                                                  height: 5.h,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      upComingController
                                                              .listUpComing[index]
                                                              .nextdate
                                                              .toString() ??
                                                          "",
                                                      style: TextStyle(
                                                        fontSize: 11.sp,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontFamily: "Quicksand",
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          Positioned(
                                            bottom: 30.sp,
                                            left: 5.sp,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Constant.secondaryColor,
                                                borderRadius:
                                                    BorderRadius.circular(15.r),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.3),
                                                    spreadRadius: 0,
                                                    blurRadius: 3,
                                                    offset: Offset(3.sp,
                                                        0), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.only(
                                                    left: 4.0.sp,
                                                    right: 4.0.sp,
                                                    top: 6.sp,
                                                    bottom: 6.sp),
                                                child: Text(
                                                  upComingController
                                                          .listUpComing[index]
                                                          .title ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 11.sp,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: "Quicksand",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          // Align(
                                          //     alignment: Alignment.topRight,
                                          //     child: Padding(
                                          //       padding: EdgeInsets.symmetric(
                                          //           vertical: 8.0.sp,
                                          //           horizontal: 8.sp),
                                          //       child: upComingController
                                          //                   .listUpComing[index]
                                          //                   .isfav ==
                                          //               true
                                          //           ? Image.asset(
                                          //               AppAssets
                                          //                       .heartSelectedPic ??
                                          //                   "",
                                          //               height: 20.h,
                                          //               width: 20.w,
                                          //             )
                                          //           : Image.asset(
                                          //               AppAssets
                                          //                       .heartUnSelectedPic ??
                                          //                   "",
                                          //               height: 20.h,
                                          //               width: 20.w,
                                          //             ),
                                          //     )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else {
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "you have no upcoming yet?",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  ),
                                  InkWell(
                                    onTap: (){
                                      Navigator.pushNamed(context, AddEventViewScreen.routeName);
                                    },

                                    child: Text(
                                      "Click to add",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Constant.secondaryColor,
                                        fontFamily: "Quicksand",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text(
                                "An error occured! Please check your internet connection."),
                          );
                        } else {
                          return const Center(
                            child: Text("Say hi to your new friend"),
                          );
                        }
                      } else {
                        return Center(
                          child: Container(),
                        );
                      }
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
