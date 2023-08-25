import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:remindly_app/models/event/upcoming/upcoming_model.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/services/ads/app_open_manager.dart';
import 'package:remindly_app/services/api/notification/notification_service.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../models/addevent/add_event_model.dart';
import '../../screens/myevent/tableclander.dart';
import '../../utils/global.dart';

class NewEventController extends GetxController {
  final dateController = TextEditingController();
  final reminderController = TextEditingController();
  final titleController = TextEditingController();
  final noteController = TextEditingController();
  final socialController = TextEditingController().obs;
  Rx<String> preFixIcon = AppAssets.phoneIcon.obs;
  SessionManager sessionManager = SessionManager();

  String newDateTime = '';

  Rx<String> selectedText = "".obs;
  Rx<String> hintText = "".obs;
  Rx<String> socialText = "".obs;
  String category = "";
  String backendDate = "";
  DateTime selectedDate = DateTime.now();
  String doccumentId = "";
  String notiId = "";
  bool isRepeat = false;
  Rx<int> remindes=0.obs;
  TimeOfDay selectedTime = TimeOfDay(
    hour: DateTime.now().hour,
    minute: DateTime.now().minute,
  );

  List<String> myWeekDays = [
    "Mon",
    "Tue",
    "Wed",
    "Thu",
    "Fri",
    "Sat",
    "Sun",
  ];

  List<String> myMonths = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Otc",
    "Nov",
    "Dec"
  ];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
    AdsApp.interstitialAd?.dispose();
  }


  Future saveEven(
      {required String catName,
      required String type,
      required String docId,
      bool? isFav,
      String? id}) async {
    try {
      if (FirebaseAuth.instance.currentUser != null) {
        AdsApp.createInterstitialAd();
        Map<String, dynamic> contactMap = {
          "info": socialController.value.text,
          "type": socialText.value,
        };
        Map<String, dynamic> repeatEventMap = {
          "isRepeat": isRepeat,
          "repeatEvery": selectedText.value,
        };

        Map<String, dynamic> newEventMap = {
          "category": catName,
          "contact": contactMap,
          "date": dateController.text,
          "nextDate": dateController.text,
          "repeatEvent": repeatEventMap,
          "isFavorite": false,
          "eventID": docId,
          "note": noteController.text,
          "reminder": reminderController.text,
          "title": titleController.text,
          "jobId": id,
        };

        if (type == "Save") {
          FirebaseFirestore.instance
              .collection("events")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("userEvents")
              .doc(docId)
              .set(newEventMap);
          Fluttertoast.showToast(
              msg: "event save Successfully!",
              backgroundColor: Colors.black,
              textColor: Colors.white);
          Get.offAllNamed(EventScreen.routeName);
        } else {
          Map<String, dynamic> UpdatecontactMap = {
            "info": socialController.value.text,
            "type": socialText.value,
          };
          Map<String, dynamic> repeatEventMapupdate = {
            "isRepeat": isRepeat,
            "repeatEvery": selectedText.value,
          };

          Map<String, dynamic> UpdateEventMap = {
            "category": catName,
            "contact": UpdatecontactMap,
            "date": dateController.text,
            "nextDate": dateController.text,
            "repeatEvent": repeatEventMapupdate,
            "isFavorite": false,
            "eventID": doccumentId,
            "note": noteController.text,
            "reminder": reminderController.text,
            "title": titleController.text,
            "jobId": id,
          };
          FirebaseFirestore.instance
              .collection("events")
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .collection("userEvents")
              .doc(doccumentId)
              .update(UpdateEventMap);
          Fluttertoast.showToast(
              msg: "event update Successfully!",
              backgroundColor: Colors.black,
              textColor: Colors.white);
          Get.offAllNamed(EventScreen.routeName);
        }

        fetchAllDat();
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  saveNotification({required String catName, required String type}) async {
    try {
      DocumentReference doc_ref = FirebaseFirestore.instance
          .collection("events")
          .doc(FirebaseAuth.instance.currentUser?.uid)
          .collection("userEvents")
          .doc();
      DocumentSnapshot docSnap = await doc_ref.get();
      var doc_id2 = docSnap.reference.id;
      String tokn = "${sessionManager.getToken()}";
      log(newDateTime);
      log(tokn.toString());
      var res = await NotificationService.saveNotification(
          title: "Reminder",
          text: "Don't forget your appointment",
          userId: FirebaseAuth.instance.currentUser!.uid,
          eventId: doc_id2,
          datetime: newDateTime,
          recurrence: "monthly",
          isSmsSubscription: "true");
      if (res.success == true) {
        saveEven(catName: catName, id: res.job?.id, type: type, docId: doc_id2);

      } else {
        log("failed to load data");
      }
    } catch (e) {
      log(e.toString());
    }
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

  updateEvent(upcomingModel) {
    String type = upcomingModel.contactMap!["info"];
    socialText.value = upcomingModel.contactMap!["type"];
    selectedText.value = upcomingModel.repeatEventMap!["repeatEvery"];
    titleController.text = upcomingModel.title ?? "";
    dateController.text = upcomingModel.date ?? "";
    doccumentId = upcomingModel.eventId;
    notiId = upcomingModel.jobId;
    reminderController.text = upcomingModel.reminders ?? "";
    noteController.text = upcomingModel.note ?? "";
    socialController.value.text = type;
    isRepeat = upcomingModel.repeatEventMap!["isRepeat"];
    preFixIcon.value = getSocialIcon(socialText.value);
    update();
  }

  clearEvent() {
    String type = "";
    socialText.value = "";
    hintText.value="Enter phone number";
    selectedText.value = "";
    titleController.text = "";
    dateController.text = "";
    reminderController.text = "";
    noteController.text = "";
    socialController.value.text = type;
    isRepeat = false;
    preFixIcon.value = getSocialIcon(socialText.value);
    update();
  }

  checkEvent(String btnText, String catName) {
    if (btnText == "Save") {
      saveNotification(catName: catName, type: btnText);
    } else {
      deleteNotification(btnText, catName);
    }
  }


  Future deleteNotification(String btnText, String catName) async {
    try {
      var res = await NotificationService.DeleteNotification(
        id: notiId,
      );
      if (res.success == true) {
        saveNotification(catName: catName, type: btnText);
      } else {
        log("failed to load data");
      }
    } catch (e) {
      log(e.toString());
      Fluttertoast.showToast(msg: "  Update Already! ");
    }
  }


  String getSocialIcon(String type) {
    String icon = "";
    switch (type) {
      case "":
        {
          icon = AppAssets.phoneIcon;
          break;
        }

      case "Phone number":
        {
          icon = AppAssets.phoneIcon;
          break;
        }
      case "Facebook":
        {
          icon = AppAssets.facebookIcon;
          break;
        }
      case "Instagram":
        {
          icon = AppAssets.instIcon;
          break;
        }

      case "Whatsapp":
        {
          icon = AppAssets.whatsIcon;
          break;
        }
    }
    return icon;
  }

  formValidation(String btnText, catName) {
    if (titleController.text.isEmpty) {
      Get.snackbar("Remindes!", "title field empty",
          backgroundColor: Constant.primaryColor);
    } else if (dateController.text.isEmpty) {
      Get.snackbar("Remindes!", "date field empty",
          backgroundColor: Constant.primaryColor);
    } else if (reminderController.text.isEmpty) {
      Get.snackbar("Remindes!", "reminder field empty",
          backgroundColor: Constant.primaryColor);
    } else if(socialText.value=="Phone number"||socialText.value=="Whatsapp"){
       if(socialController.value.text.length>7||socialController.value.text.length<16){
         checkEvent(btnText, catName);
      }
       else{
         Get.snackbar("Remindes!", "phone Number incorrect!",
             backgroundColor: Constant.primaryColor);
       }
    }
     else {
      checkEvent(btnText, catName);
    }
  }

  checkDiff(DateTime selectedDate){
    DateTime now=DateTime.now();
    final difference = selectedDate.difference(now).inDays;
    remindes.value=difference;


  }
}
