import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/models/event/upcoming/upcoming_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../services/firebase/firebase.dart';
import '../../../widget/app_button.dart';

class UpComingController extends GetxController {
  List<Upcoming> upcomingEventList = <Upcoming>[];
  UpcomingModel modelUpComing = UpcomingModel();
  List<UpcomingModel> listUpComing = <UpcomingModel>[].obs;
  List<UpcomingModel> listEventDate = <UpcomingModel>[].obs;
  List<UpcomingModel> calennderList = <UpcomingModel>[].obs;
  List<UpcomingModel> list = <UpcomingModel>[].obs;

  // List<Event> listDate=<Event>[];

  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  final Connectivity _connectivity = Connectivity();
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  Rx<bool> isLoading=false.obs;
  bool seeval=true;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getToken();
    addList();
  }

  @override
  void dispose() {
    super.dispose();
    _connectivitySubscription.cancel();
  }

  DateTime selectedDate = DateTime.now();
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

  void addList() {
    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.workPic,
        heartIcon: AppAssets.heartSelectedPic,
        date: "june 12, 2022",
        type: "monthly Meeting",
      ),
    );
    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.weddingPic,
        heartIcon: AppAssets.heartUnSelectedPic,
        date: "May 12, 2022",
        type: "Robin Birthday",
      ),
    );
    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.workPic,
        heartIcon: AppAssets.heartSelectedPic,
        date: "june 17, 2022",
        type: "monthly Meeting",
      ),
    );
    upcomingEventList.add(
      Upcoming(
        ImageUrl: AppAssets.lecturePic,
        heartIcon: AppAssets.heartUnSelectedPic,
        date: "May 15, 2022",
        type: "someone Birthday",
      ),
    );
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      print(e);
      return;
    }
    update();
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    connectionStatus = result;
    update();
  }

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      importance: Importance.high,
      playSound: true);

  // ignore: non_constant_identifier_names
  void Notification(context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // String riderequestid = "";
      // riderequestid = message.data['ride_request_id'];
      // print('A bg message just showed up::');
      //print(riderequestid);
      //retriveRideRequestInfo(riderequestid);
      print(message);

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                color: Colors.blue,
                onlyAlertOnce: true,
                playSound: true,
                icon: '@mipmap/launcher_icon',
              ),
            ));
      }
    });
  }

  // Future  fetchAlldata() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('events')
  //       .doc(currentFireBaseUser?.uid)
  //       .collection("userEvents")
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     var docData = querySnapshot.docs;
  //     for (int i = 0; i < docData.length; i++) {
  //       modelUpComing.value = UpcomingModel.fromJson(docData[i].data() as Map<String, dynamic>);
  //       getImageIcon(modelUpComing.value.cat, modelUpComing.value);
  //       listUpComing.add(modelUpComing.value);
  //       print(listUpComing);
  //     }
  //
  //     print(modelUpComing);
  //   }
  // }

  // Future  fetchFavEvent() async {
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('events')
  //       .doc(currentFireBaseUser?.uid)
  //       .collection("userEvents")
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     var docData = querySnapshot.docs;
  //     for (int i = 0; i < docData.length; i++) {
  //       modelUpComing.value = UpcomingModel.fromJson(docData[i].data() as Map<String, dynamic>);
  //       if(modelUpComing.value.isfav==true){
  //         favlist.add(modelUpComing.value);
  //       };
  //     }
  //
  //     print(modelUpComing);
  //   }
  // }

  // Future getAlldata(DateTime day)async{
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('events')
  //       .doc(currentFireBaseUser?.uid)
  //       .collection("userEvents")
  //       .get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     var docData = querySnapshot.docs;
  //     for (int i = 0; i < docData.length; i++) {
  //       modelUpComing.value = UpcomingModel.fromJson(docData[i].data() as Map<String, dynamic>);
  //       DateTime checkDate=DateTime.parse(modelUpComing.value.date??"");
  //       if(day.year==checkDate.year&&day.month==checkDate.month&&day.day==checkDate.){
  //         listDate.add(Event(modelUpComing.value.title??""));
  //       }
  //       }
  //     }
  //
  //     print(modelUpComing);
  //   }
  getImageIcon(String? iconName, UpcomingModel model) {
    isLoading.value=true;
    seeval=true;
    switch (iconName) {
      case "Work":
        {
          model.iconUrl = AppAssets.workPic;
          break;
        }
      case "Birthday":
        {
          model.iconUrl = AppAssets.cakePic;
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
          break;
        }
      case "Lunch / Dinner":
        {
          model.iconUrl = AppAssets.breakFastPic;
          break;
        }
      case "Event":
        {
          model.iconUrl = AppAssets.calenderPic;
          break;
        }
      case "Concert / Party":
        {
          model.iconUrl = AppAssets.concertPic;
          break;
        }
      case "Seminar":
        {
          model.iconUrl = AppAssets.lecturePic;
          break;
        }
    }
        isLoading.value=false;
    update();
  }

  getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token);
  }



   setSeeAllVal(bool val) {
    seeval = val;
    update();
  }
}


