import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/models/event/nearest/nearest_model.dart';
import 'package:remindly_app/services/firebase/firebase.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../models/addevent/add_event_model.dart';
import '../../../screens/myevent/tableclander.dart';
import '../../../utils/assets_image_path.dart';
import '../../../utils/constants.dart';
import '../../../widget/app_button.dart';

class NearestController extends GetxController {
  NearestModel nearestModel = NearestModel();
  DialogModel dialogModel = DialogModel();
  DialogModel listnearestModel = DialogModel();
  List<NearestModel> listNear = <NearestModel>[];
  Rx<NearestModel> model = NearestModel().obs;
  var closeDate = DateTime.now();


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllDat();
    getForDialog();

  }



  fetchAllDat() async {
    final snapshot = await FirebaseFirestore.instance
        .collection("events")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("userEvents")
        .get();
    QuerySnapshot dataSnapshot = snapshot;
    allList = [];
    for (var doc in dataSnapshot.docs) {
      addEventsModel.value =
          ModelAddEvent.fromJson(doc.data() as Map<String, dynamic>);
      allList.add(addEventsModel.value);
    }
    print(allList.length);

    update();
  }

  launchInstagram(String username) async {
    launchUrl(
      Uri.parse('https://www.instagram.com/${username}'),
      mode: LaunchMode.externalApplication,
    );
  }

  launchFacebook(String username) async {
    launchUrl(
      Uri.parse('https://www.Facebook.com/${username}'),
      mode: LaunchMode.externalApplication,
    );
  }

  launchWhatsApp(String whatsapp) async {
    launchUrl(
      Uri.parse('whatsapp://send?phone=$whatsapp&text=hello'),
      mode: LaunchMode.externalApplication,
    );
  }

  launchSMS(String phoneNumber) async {
    launchUrl(
      Uri.parse('sms:$phoneNumber?body=${Uri.encodeComponent("Hello there")}'),
      mode: LaunchMode.externalApplication,
    );
  }

  getnearestIcon(String? iconName, model) {
    switch (iconName) {
      case "Work":
        {
          model.iconUrl = AppAssets.workPic;
          dialogModel.lottieIcon = "assets/gifs/work.json";
          break;
        }
      case "Birthday":
        {
          model.iconUrl = AppAssets.cakePic;
          dialogModel.lottieIcon = "assets/gifs/birthday.json";
          break;
        }
      case "lecture":
        {
          model.iconUrl = AppAssets.lecturePic;
          break;
        }
      case "Anniversary":
        {
          model.iconUrl = AppAssets.weddingPic;
          dialogModel.lottieIcon = "assets/gifs/anniversary.json";
          break;
        }
      case "Lunch / Dinner":
        {
          model.iconUrl = AppAssets.breakFastPic;
          dialogModel.lottieIcon = "assets/gifs/dinner.json";
          break;
        }
      case "Event":
        {
          model.iconUrl = AppAssets.calenderPic;
          dialogModel.lottieIcon = "assets/gifs/event.json";
          break;
        }
      case "Concert / Party":
        {
          model.iconUrl = AppAssets.concertPic;
          dialogModel.lottieIcon = "assets/gifs/concert.json";
          break;
        }
      case "Seminar":
        {
          model.iconUrl = AppAssets.lecturePic;
          dialogModel.lottieIcon = "assets/gifs/seminar.json";
          break;
        }
    }
  }

  getForDialog() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection("events")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("userEvents")
          .get();
      QuerySnapshot dataSnapshot = snapshot;
      for (var doc in dataSnapshot.docs) {
        var elementDate =
            DateFormat("MMM-d-yyyy, " 'h:mm a').parse(doc["nextDate"]);
        dialogModel = DialogModel.fromJson(doc.data() as Map<String, dynamic>);

        if (elementDate.isAfter(DateTime.now())) {
          if (elementDate.day.compareTo(DateTime.now().day) == 0 &&
              elementDate.month.compareTo(DateTime.now().month) == 0) {
            if (elementDate.isBefore(closeDate)) {
              listnearestModel = dialogModel;
              closeDate = elementDate;
              print(closeDate);
              getnearestIcon(dialogModel.cat, dialogModel);
            } else {
              listnearestModel = dialogModel;
              closeDate = elementDate;
              print(closeDate);
              getnearestIcon(dialogModel.cat, dialogModel);
            }
          }
        }
      }
      listnearestModel.lottieIcon == null
          ? Container()
          : showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return showDialogIfNotConnect(listnearestModel.cat,
                    listnearestModel.lottieIcon, listnearestModel.title);
              });
    } catch (e) {
      print(e);
    }
  }

  showDialogIfNotConnect(String? Cat, String? Image, String? title) {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: 400.h,
          width: Get.width - 30.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0.sp),
                child: Text(
                  Cat ?? "",
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 24.sp,
                    color: Colors.black,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Lottie.asset(Image ?? "", height: 200.h, width: 200.w),
              Text(
                title ?? "",
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 20.sp,
                  color: Constant.primaryColor,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: 10.0.sp, left: 10.sp, right: 10.sp, bottom: 10.sp),
                child: Container(
                  height: 45.h,
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
                    minBtnHeight: 40.h,
                    borderRadius: 25.r,
                    maxBtnHeight: 40.h,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    text: 'Got it',
                    onClick: () {
                      Get.back();
                    },
                    color: Colors.transparent,
                    textColor: Constant.backgroundColor,
                  ),
                ),
              ),
              SizedBox(height: 10.sp)
            ],
          ),
        ));
  }
}
