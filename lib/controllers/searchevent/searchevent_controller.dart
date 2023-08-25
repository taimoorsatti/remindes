import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/searchevent/searchevent_model.dart';
import '../../utils/assets_image_path.dart';

class SearchEventController extends GetxController {
  Rx<SearchEventModel> searchEventModel = SearchEventModel().obs;
  List<SearchEventModel> searchEventList = <SearchEventModel>[].obs;
  List<SearchEventModel> checckEventList = <SearchEventModel>[].obs;
  Rx<bool> Loading=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkSearchEvent();
  }

  getSearchEvent(String name) async {

    final snapshot = await FirebaseFirestore.instance
        .collection("events")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("userEvents")
        .snapshots()
        .listen((querySnapshot) {
      searchEventList=[];
      querySnapshot.docs.forEach((change) {
        searchEventModel.value =
            SearchEventModel.fromJson(change.data());
        if (searchEventModel.value.title!.contains(name)) {
          getIconForSearchEvent(
              searchEventModel.value.cat, searchEventModel.value);
          searchEventList.add(searchEventModel.value);

        }
      });
      Future.delayed(Duration(milliseconds: 300)).then((_) {
        Loading.value=false;
      });

      update();
    });

    print(searchEventList);

    update();
  }


  checkSearchEvent() async {
    Loading.value=true;
    final snapshot = await FirebaseFirestore.instance
        .collection("events")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("userEvents")
        .snapshots()
        .listen((querySnapshot) {
      querySnapshot.docs.forEach((change) {
        searchEventModel.value =
            SearchEventModel.fromJson(change.data());
        checckEventList.add(searchEventModel.value);
      });
      getSearchEvent("");
      update();
    });

    print(searchEventList);

    update();
  }




  getIconForSearchEvent(String? iconName, SearchEventModel model) {
    switch (iconName) {
      case "Work":
        {
          model.iconUrl = AppAssets.workPic;
          break;
        }
      case "BirthDay":
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
    }
  }
}
