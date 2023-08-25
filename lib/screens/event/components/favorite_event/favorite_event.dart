import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remindly_app/controllers/searchevent/searchevent_controller.dart';
import 'package:remindly_app/models/event/favorite/fav_model.dart';
import 'package:remindly_app/screens/searchevent/searchview.dart';
import 'package:remindly_app/services/firebase/firebase.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:remindly_app/utils/constants.dart';

import '../../../../controllers/event/favorite/favorite.dart';
import '../../../../controllers/event/upcoming/upcoming_controller.dart';
import '../../../../utils/global.dart';
import '../../../addevent/add_event_view.dart';
import '../../event_view.dart';

class FavoriteEvent extends StatelessWidget {
  final String? imagePath;
  final String? type;
  final String? date;
  final String? favIcon;

  FavoriteEvent({this.date, this.type, this.imagePath, this.favIcon});

  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.sp, vertical: 10.sp),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Favorite Events",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              fontFamily: "Quicksand",
              color: Constant.primaryColor,
            ),
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
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    favoriteController.favList = [];
                    QuerySnapshot dataSnapshot =
                        snapshot.data as QuerySnapshot;

                    for (var doc in dataSnapshot.docs) {
                      var elementDate =
                      DateFormat("MMM-d-yyyy, " 'h:mm a')
                          .parse(doc["nextDate"]);

                      if (doc["isFavorite"] && elementDate.isAfter(DateTime.now())) {
                        favoriteController.fModel = favModel
                            .fromJson(doc.data() as Map<String, dynamic>);
                        favoriteController.getImagefav(
                            favoriteController.fModel.cat,
                            favoriteController.fModel);
                        favoriteController.favList
                            .add(favoriteController.fModel);
                      }
                    }
                    return favoriteController.favList.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "You have no favorite yet?",
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
                                    Navigator.pushNamed(context,SearchView.routeName);
                                  },
                                  child: Text(
                                    "Click to add",
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      fontWeight: FontWeight.w600,
                                      color: Constant.primaryColor,
                                      fontFamily: "Quicksand",
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: favoriteController.favList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding:
                                    EdgeInsets.symmetric(horizontal: 6.0.sp),
                                child: Container(
                                  width: 150.w,
                                  decoration: BoxDecoration(
                                    color: Constant.secondaryColor,
                                    borderRadius: BorderRadius.circular(20.r),
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
                                              favoriteController
                                                      .favList[index]
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
                                                  favoriteController
                                                          .favList[index]
                                                          .date??
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
                                                offset: const Offset(3,
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
                                              favoriteController
                                                      .favList[index].title ??
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
                                      InkWell(
                                        onTap: () {
                                          // FirebaseFirestore.instance.collection(
                                          //     "events").doc(
                                          //     currentFireBaseUser?.uid).collection(
                                          //     "userEvents").doc(
                                          //     favoriteController
                                          //         .favList[index]
                                          //         .docId
                                          // ).update({"isFavourite": false});
                                        },
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 8.0.sp,
                                                  horizontal: 8.sp),
                                              child: Image.asset(
                                                AppAssets.heartSelectedPic ??
                                                    "",
                                                height: 20.h,
                                                width: 20.w,
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                          ""),
                    );
                  } else {
                    return const Center(
                      child: Text(""),
                    );
                  }
                } else {
                  return Center(
                    child: Container(),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
