import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/newevent/newevent_controller.dart';
import 'package:remindly_app/widget/app_button.dart';

import 'date_selection_container.dart';

class emailvarify extends StatefulWidget {
  final String ?titleText;
  String? onClick;

  emailvarify({this.onClick,this.titleText});

  @override
  State<emailvarify> createState() => _emailvarifyState();
}

class _emailvarifyState extends State<emailvarify> {
  late double screenHeight;
  NewEventController controllerNewEvent=Get.put(NewEventController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          height: MediaQuery
              .of(context)
              .size
              .height * 0.6,
          width: 200.w,
          padding: const EdgeInsets.only(left: 15, right: 15, top: 22),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const CircularProgressIndicator(),
              SizedBox(height: 10.h,),
              const Text("Verifying email...."),
            ],
          ),
        ),
      ),);
  }
}
