import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:remindly_app/screens/newevent/components/body.dart';

import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../models/event/upcoming/upcoming_model.dart';
import '../../utils/constants.dart';

class NewEventViewScreen extends StatelessWidget {
  static const routeName="/newevent";
  final String eventName;
  final String btnText;
  final UpcomingModel? upcoming;
   NewEventViewScreen({required this.eventName,this.upcoming,required this.btnText});
  CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Constant.backgroundColor,
        statusBarColor: Constant.backgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return  Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: SafeArea(child: NewEventBody(eventName: eventName,btnText:btnText)),

    );
  }
}
