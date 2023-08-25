import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/screens/event/components/upcoming_event/upcoming.dart';

import '../../../controllers/event/upcoming/upcoming_controller.dart';
import '../../../utils/constants.dart';
import '../../addevent/add_event_view.dart';
import 'favorite_event/favorite_event.dart';
import 'nearest_event/nearest_event.dart';

class EventBody extends StatefulWidget {
    EventBody({Key? key}) : super(key: key);

  @override
  State<EventBody> createState() => _EventBodyState();
}

class _EventBodyState extends State<EventBody> {

  bool isLoading=true;
@override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        isLoading = false;
      });
    });
}



  @override
  Widget build(BuildContext context) {

    return
      Stack(
        children: [
          ListView(
            shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children:   [
             NearestEvent(),
            SizedBox(height: 10.h,),
            UpComingEvent(),
            FavoriteEvent(),
          ],
    ),
          isLoading?Center(
            child:Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp),
          ):Container(),

          Positioned(
              top: 20.sp,
              right: 30.sp,
              child: Container(
                height: 40.sp,
                width: 40.sp,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    Get.to(AddEventViewScreen());
                  },
                  backgroundColor: Constant.primaryColor,
                  elevation: 2,
                  child:  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 30.sp
                  ),
                ),
              )),

        ],
      );

  }
}
