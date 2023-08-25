import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/models/event/nearest/nearest_model.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../../controllers/event/nearest/nearest_controller.dart';
import '../../../../utils/global.dart';

class NearestEvent extends StatelessWidget {
  NearestEvent({Key? key}) : super(key: key);
  NearestController nearestController = Get.put(NearestController());
  var closeDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    nearestController.model.value=NearestModel();
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 20.h,
          ),
          GradientText(
            "Today's Event!",
            style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
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
          SizedBox(
            height: 20.h,
          ),
          Container(
            height: 250.h,
            width: double.infinity.w,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Constant.primaryColor,
                  Constant.secondaryColor,
                ],
              ),
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("events")
                  .doc(FirebaseAuth.instance.currentUser?.uid)
                  .collection("userEvents")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    QuerySnapshot dataSnapshot = snapshot.data as QuerySnapshot;
                    if (dataSnapshot.docs.isNotEmpty) {
                      closeDate = DateFormat("MMM-d-yyyy, " 'h:mm a')
                          .parse(dataSnapshot.docs[0]["nextDate"]);

                      for (var doc in dataSnapshot.docs) {
                        var elementDate = DateFormat("MMM-d-yyyy, " 'h:mm a')
                            .parse(doc["nextDate"]);
                        nearestController.nearestModel = NearestModel.fromJson(
                            doc.data() as Map<String, dynamic>);

                        if (elementDate.isAfter(DateTime.now())) {
                          if (elementDate.day.compareTo(DateTime.now().day) ==
                                  0 &&
                              elementDate.month
                                      .compareTo(DateTime.now().month) ==
                                  0) {
                            if (elementDate.isBefore(closeDate)) {
                              nearestController.model.value =
                                  nearestController.nearestModel;
                              closeDate = elementDate;
                              print(closeDate);
                              nearestController.getnearestIcon(
                                  nearestController.nearestModel.cat,
                                  nearestController.nearestModel);
                            } else {
                              nearestController.model.value =
                                  nearestController.nearestModel;
                              closeDate = elementDate;
                              print(closeDate);
                              nearestController.getnearestIcon(
                                  nearestController.nearestModel.cat,
                                  nearestController.nearestModel);
                            }
                          }
                        }
                      }
                    }
                    return nearestController.model.value.jobId == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppAssets.noEventIcon,
                                height: 90.h,
                                width: 90.w,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: 10.sp,
                              ),
                              Text(
                                "No Event scheduled",
                                style: TextStyle(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                            ],
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                nearestController.model.value.iconUrl ??
                                    AppAssets.cakePic,
                                height: 80.h,
                                width: 80.w,
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              Text(
                                nearestController.model.value.title ?? "",
                                style: TextStyle(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Quicksand",
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Text(
                                nearestController.model.value.nextDate
                                    .toString(),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: "Quicksand",
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              InkWell(
                                onTap: () {
                                  nearestController.model.value
                                              .contactMap!["type"] ==
                                          "Facebook"
                                      ? nearestController.launchFacebook(
                                          nearestController
                                              .model.value.contactMap!["info"]
                                              .toString(),
                                        )
                                      : nearestController.model.value
                                                  .contactMap!["type"] ==
                                              "Phone number"
                                          ? nearestController.launchSMS(
                                              nearestController.model.value
                                                  .contactMap!["info"]
                                                  .toString(),
                                            )
                                          : nearestController.model.value
                                                      .contactMap!["type"] ==
                                                  "Instagram"
                                              ? nearestController
                                                  .launchInstagram(
                                                  nearestController.model.value
                                                      .contactMap!["info"]
                                                      .toString(),
                                                )
                                              : nearestController.model.value
                                                              .contactMap![
                                                          "type"] ==
                                                      "Whatsapp"
                                                  ? nearestController
                                                      .launchWhatsApp(
                                                      nearestController
                                                          .model
                                                          .value
                                                          .contactMap!["info"]
                                                          .toString(),
                                                    )
                                                  : AppAssets.uncheck;
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    nearestController.model.value
                                                    .contactMap!["type"] ==
                                                "" ||
                                            nearestController.model.value
                                                    .contactMap!["info"] ==
                                                ""
                                        ? Container()
                                        : Image.asset(
                                            nearestController.model.value
                                                        .contactMap!["type"] ==
                                                    "Facebook"
                                                ? AppAssets.facebookIcon
                                                : nearestController.model.value
                                                                .contactMap![
                                                            "type"] ==
                                                        "Phone number"
                                                    ? AppAssets.phoneIcon
                                                    : nearestController
                                                                    .model
                                                                    .value
                                                                    .contactMap![
                                                                "type"] ==
                                                            "Instagram"
                                                        ? AppAssets.instIcon
                                                        : nearestController
                                                                        .model
                                                                        .value
                                                                        .contactMap![
                                                                    "type"] ==
                                                                "Whatsapp"
                                                            ? AppAssets
                                                                .whatsIcon
                                                            : AppAssets.uncheck,
                                            height: 20.sp,
                                            width: 20.sp,
                                          ),
                                    SizedBox(width: 5.sp),
                                    nearestController.model.value
                                                    .contactMap!["type"] ==
                                                "" ||
                                            nearestController.model.value
                                                    .contactMap!["info"] ==
                                                ""
                                        ? Text("")
                                        : Text(
                                            nearestController
                                                .model.value.contactMap!["info"]
                                                .toString(),
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Quicksand",
                                              color: Colors.white,
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ],
                          );
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppAssets.noEventIcon,
                          height: 90.h,
                          width: 90.w,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10.sp,
                        ),
                        Text(
                          "No Event scheduled",
                          style: TextStyle(
                            fontSize: 25.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: "Quicksand",
                          ),
                        ),
                      ],
                    );
                  }
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text(""),
                  );
                } else {
                  return Center(
                    child: Text(""),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
