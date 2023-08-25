import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:remindly_app/models/addevent/add_event_model.dart';
import 'package:remindly_app/utils/assets_image_path.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../screens/myevent/tableclander.dart';

class AddEventController extends GetxController{

  List<AddEventModel> listAddEvent=<AddEventModel>[];
  List<AddEventModel> listCalender=<AddEventModel>[];
  Rx<ModelAddEvent> addEventsModel =ModelAddEvent().obs;
  List<ModelAddEvent> calenderList=<ModelAddEvent>[].obs;
  int totalCount=0;
  List<ModelAddEvent> calenderdateList=<ModelAddEvent>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    AddList();
    listAdd();


  }


  List<dynamic> getList(DateTime date){
    List <dynamic> allEvent=<dynamic>[];
    Map<DateTime,List<dynamic>> map={};
    for (int i = 0; i < Get.find<AddEventController>().listCalender.length; i++) {
      DateTime datetime=DateTime(date.year,date.year,date.month);
      if(map[datetime]==null) map[datetime]=[];
      map[datetime]?.add("item${i}");
    }
    allEvent.add(map);
    print(allEvent);
    return allEvent;
  }


  void AddList(){
    listAddEvent.add(
      AddEventModel(
        type: "Work",
        iconUrl: AppAssets.workPic,
        date:DateTime(2023,6,20)
      )
    );
    listAddEvent.add(
        AddEventModel(
            type: "Birthday",
            iconUrl: AppAssets.cakePic,
            date:DateTime(2023,6,21)
        )
    );
    listAddEvent.add(
        AddEventModel(
          type: "Anniversary",
          iconUrl: AppAssets.weddingPic,
            date:DateTime(2023,6,22)
        )
    );
    listAddEvent.add(
        AddEventModel(
          type: "Lunch / Dinner",
          iconUrl: AppAssets.breakFastPic,
            date:DateTime(2023,6,22)
        )
    );
    listAddEvent.add(
        AddEventModel(
          type: "Event",
          iconUrl: AppAssets.calenderPic,
            date:DateTime(2023,6,24)
        )
    );
    listAddEvent.add(
        AddEventModel(
          type: "Concert / Party",
          iconUrl: AppAssets.concertPic,
            date:DateTime(2023,6,24)
        )
    );
    listAddEvent.add(
        AddEventModel(
            type: "Seminar",
            iconUrl: AppAssets.lecturePic,
            date:DateTime(2023,6,24)
        )
    );
  }

  void listAdd(){
    for(int i=0;i<allList.length;i++){
      print(allList.length);
     DateTime date= DateFormat("MMM-d-yyyy, " 'h:mm a').parse(allList[i].date!);
     listCalender.add(
          AddEventModel(
              type: "BirthDay",
              iconUrl: AppAssets.cakePic,
              date:date
          )
      );

    }
    print(listCalender);
    update();
  }




//   final kEvents = LinkedHashMap<DateTime, List<dynamic>>(
//     equals: isSameDay,
//   )..addAll(getTask1);
//
// Map<DateTime, List> getTask1() {
//   Map<DateTime, List> mapFetch = {};
//   AddEventController addEvent = Get.put(AddEventController());
//
//   print(addEvent.allList.length);
//   for (int i = 0; i < 10; i++) {
//     DateTime myDate = DateFormat('yyyy-MM-dd').parse(addEvent.allList[i].date!);
//     var createTime = DateTime(myDate.year, myDate.month, myDate.day);
//     var original = mapFetch[createTime];
//     if (original == null) {
//       print("null");
//       mapFetch[createTime] = [addEvent.allList[i].title];
//     } else {
//       print(addEvent.allList[i].title);
//       mapFetch[createTime] = List.from(original);
//     }
//   }
//
//   return mapFetch;
// }





}