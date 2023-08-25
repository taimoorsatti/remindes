import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/controllers/addevent/add_event_controller.dart';
import 'package:remindly_app/controllers/setting/setting_controller.dart';
import 'package:remindly_app/models/addevent/add_event_model.dart';
import 'package:remindly_app/screens/setting/setting_view.dart';
import 'package:remindly_app/utils/constants.dart';
import 'package:remindly_app/utils/global.dart';
import 'package:table_calendar/table_calendar.dart';

import '../addevent/add_event_view.dart';
import '../event/event_view.dart';

Rx<ModelAddEvent> addEventsModel = ModelAddEvent().obs;
List<ModelAddEvent> allList = <ModelAddEvent>[].obs;

class TableEventsExample extends StatefulWidget {
  static const routeName="/myevent";
  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  //late final ValueNotifier<List<Event>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  List<ModelAddEvent> listdata = [];
  AddEventController addEventController = Get.put(AddEventController());
  int totalCount = 0;
  bool isloop = false;
  bool isLoading=true;
  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
      Future.delayed(const Duration(milliseconds: 1000), () {
        setState(() {
          isLoading = false;
        });
      });

  }

  @override
  void dispose() {
    //_selectedEvents.dispose();
    super.dispose();
  }

  int _index = 1;
  List<dynamic> eventList = <dynamic>[];

  List<dynamic> _getEventsFor(DateTime day) {
    final data = getListEvent(day);
    print(data);
    return data;
  }

  void _onDaySelect(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
      });
    }
  }

  List<dynamic> getListEvent(DateTime date) {
    List StringData = [];
    isloop = false;
    for (int i = 0; i < allList.length; i++) {
      allList[i].date.toString();

      var closeData =
          DateFormat("MMM-d-yyyy, " 'h:mm a').parse(allList[i].date.toString());
      if (date.year == closeData.year &&
          date.month == closeData.month &&
          date.day == closeData.day) {
        isloop = true;
        StringData.add("item${i}");
        print(StringData);
      } else {
        if (isloop) {
          StringData = StringData;
        } else {
          StringData = [];
        }
      }
    }
    return StringData;
  }

  @override
  Widget build(BuildContext context) {

    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.light);
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return GetBuilder(
      init: AddEventController(),
      builder: (AddEventController viewModel) {
        return Scaffold(
          backgroundColor: Constant.backgroundColor,
          extendBody: true,
          bottomNavigationBar: FloatingNavbar(
            width: Get.width - 120.w,
            selectedBackgroundColor: Colors.white,
            borderRadius: 40.r,
            selectedItemColor: Constant.secondaryColor,
            unselectedItemColor: Colors.grey,
            backgroundColor: Colors.white,
            elevation: 100,
            onTap: (int val) {
              setState(() {
                _index = val;
              });
              if (val == 0) {
                Get.offAllNamed(EventScreen.routeName);
              } else if (val == 2) {
                Get.find<SettingController>().checkAnonymous();
                Get.offAllNamed(SettingView.routeName);
              }
            },
            currentIndex: _index,
            items: [
              FloatingNavbarItem(
                icon: Icons.home_sharp,
              ),
              FloatingNavbarItem(icon: Icons.list_alt_sharp),
              FloatingNavbarItem(
                icon: Icons.settings,
              ),
            ],
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 20.0.sp, horizontal: 15.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40.sp,
                        ),
                       GradientText(
                          "My Events",
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: Constant.primaryColor,
                            fontFamily: "Quicksand",
                          ),
                         gradient:LinearGradient(
                           begin: Alignment.topCenter,
                           end: Alignment.bottomCenter,
                           colors: [
                             Constant.primaryColor,
                             Constant.secondaryColor,
                           ],
                         ),
                        ),
                        SizedBox(
                          height: 20.sp,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Constant.primaryColor,
                                Constant.secondaryColor,
                              ],
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(
                                    1, 1), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(8.0.sp),
                            child: TableCalendar<dynamic>(
                              headerStyle: HeaderStyle(
                                formatButtonVisible: false,
                                titleCentered: true,
                                leftChevronVisible: false,
                                rightChevronVisible: false,
                                titleTextStyle: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                              firstDay: kFirstDay,
                              lastDay: kLastDay,
                              focusedDay: _focusedDay,
                              rowHeight: 35.sp,
                              daysOfWeekHeight: 20.sp,
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.blueLightText,
                                  fontFamily: "Quicksand",
                                ),
                                weekendStyle: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Constant.blueLightText,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                              selectedDayPredicate: (day) =>
                                  isSameDay(_selectedDay, day),
                              rangeStartDay: _rangeStart,
                              rangeEndDay: _rangeEnd,
                              calendarFormat: _calendarFormat,
                              rangeSelectionMode: _rangeSelectionMode,
                              eventLoader: _getEventsFor,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              calendarStyle:  CalendarStyle(
                                markerMargin: EdgeInsets.only(top: 5.sp,right: 2.sp),
                                markerSize: 5.sp,
                                markerDecoration: BoxDecoration(
                                  color: Colors.black,
                                  shape: BoxShape.circle,
                                ),
                                outsideDaysVisible: true,
                                weekendTextStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                ),
                                defaultTextStyle: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                  fontFamily: "Quicksand",
                                ),
                              ),
                              onDaySelected: _onDaySelect,
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  setState(() {
                                    _calendarFormat = CalendarFormat.month;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("events")
                        .doc(FirebaseAuth.instance.currentUser?.uid)
                        .collection("userEvents")
                        .snapshots(),
                    builder: (context, snapshot) {
                      addEventController.calenderList = [];
                      if (snapshot.connectionState ==
                          ConnectionState.active) {
                        if (snapshot.hasData) {
                          QuerySnapshot dataSnapshot =
                              snapshot.data as QuerySnapshot;
                          dataSnapshot.docs.forEach((doc) {
                            addEventController.addEventsModel.value =
                                ModelAddEvent.fromJson(
                                    doc.data() as Map<String, dynamic>);
                            var elementDate =
                                DateFormat("MMM-d-yyyy, " 'h:mm a')
                                    .parse(doc["date"]);
                            if (_selectedDay?.day == elementDate.day &&
                                _selectedDay?.month == elementDate.month &&
                                _selectedDay?.year == elementDate.year) {
                              addEventController.calenderList.add(
                                  addEventController.addEventsModel.value);
                            }
                            print(addEventController.calenderList);
                          });
                          return Expanded(
                            child: Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10.0.sp, horizontal: 20.sp),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "On this day",
                                        style: TextStyle(
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontFamily: "Quicksand",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.sp,
                                ),
                                addEventController.calenderList.isEmpty
                                    ? Expanded(
                                        child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Nothing Planned",
                                            style: TextStyle(
                                              fontSize: 16.sp,
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
                                              Get.to(AddEventViewScreen());
                                            },
                                            child: Text(
                                              "Click to add",
                                              style: TextStyle(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w600,
                                                color: Constant.secondaryColor,
                                                fontFamily: "Quicksand",
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 60.sp),
                                        ],
                                      ))
                                    : Expanded(
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: addEventController
                                              .calenderList.length,
                                          itemBuilder: (context, index) {
                                            return Column(
                                              children: [
                                                SizedBox(height: 10.sp,),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: [
                                                    Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Padding(
                                                          padding: EdgeInsets.only(top: 8.0.sp),
                                                          child: Container(
                                                            height: 12.sp,
                                                            width: 12.sp,
                                                            decoration:
                                                                const BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Constant
                                                                        .blueLightText),
                                                          ),
                                                        ),
                                                        SizedBox(width: 10.sp,),
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              addEventController
                                                                      .calenderList[
                                                                          index]
                                                                      .title ??
                                                                  "",
                                                              style:
                                                                  TextStyle(
                                                                fontSize:
                                                                    18.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                color: Colors
                                                                    .black,
                                                                fontFamily:
                                                                    "Quicksand",
                                                              ),
                                                            ),
                                                            SizedBox(height: 10.sp,),
                                                             Text(
                                                                addEventController
                                                                        .calenderList[
                                                                            index]
                                                                        .date ??
                                                                    "",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      15.sp,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .black,
                                                                  fontFamily:
                                                                      "Quicksand",
                                                                ),
                                                              ),

                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Container(),
                                                  ],
                                                ),
                                                SizedBox(height: 10.sp,),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.sp,
                                                          horizontal:
                                                              25.sp),
                                                  child: Container(
                                                    height: 1,
                                                    color: Constant
                                                        .colorTextFieldeBorder
                                                        .withOpacity(0.5),
                                                  ),
                                                )
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text(
                                ""),
                          );
                        } else {
                          return Center(
                            child: Text(""),
                          );
                        }
                      } else {
                        return Center(child: Text(""));
                      }
                    },
                  ),
                ],
              ),
              isLoading?Center(
                child:Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp),
              ):Container(),
              Positioned(
                  bottom: 100.sp,
                  right: 20.sp,
                  child: Container(
                    height: 50.sp,
                    width: 50.sp,
                    child: FloatingActionButton(
                      heroTag: "btn2",
                      onPressed: () {
                        Navigator.push(
                          Get.context!,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: AddEventViewScreen(),
                          ),
                        );
                      },
                      backgroundColor: Constant.primaryColor,
                      elevation: 2,
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )),
            ],
          ),
        );
      },
    );
  }
}

AddEventController addEvent = Get.put(AddEventController());

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

final kEvents = Map<DateTime, List<dynamic>>()..addAll(_kEventSource);

final _kEventSource = {
  for (var item in List.generate(allList.length, (index) => index))
    DateTime.utc(
            Get.find<AddEventController>().listCalender[item].date!.year,
            Get.find<AddEventController>().listCalender[item].date!.month,
            Get.find<AddEventController>().listCalender[item].date!.day):
        List.generate(
            getList(DateTime(
                Get.find<AddEventController>().listCalender[item].date!.year,
                Get.find<AddEventController>().listCalender[item].date!.month,
                Get.find<AddEventController>().listCalender[item].date!.day)),
            (index) => Event('Event $item'))
};

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);

int getList(DateTime date) {
  int totalcount = 0;
  for (int i = 0; i < Get.find<AddEventController>().listCalender.length; i++) {
    if (date.year ==
            Get.find<AddEventController>().listCalender[i].date!.year &&
        date.month ==
            Get.find<AddEventController>().listCalender[i].date!.month &&
        date.day == Get.find<AddEventController>().listCalender[i].date!.day) {
      totalcount = totalcount + 1;
    }
  }
  print(totalcount);
  return totalcount;
}

class CleanCalendarEvent {
  String? eventname;

  CleanCalendarEvent({this.eventname});
}
