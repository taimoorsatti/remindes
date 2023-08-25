import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';




commonBottomSheet(
    BuildContext context, {
      Widget? widget,
      double? sheetHeight,
    }) {
  final _formkey = GlobalKey<FormState>();
  ScrollController _scrollControll=ScrollController();

  return showModalBottomSheet(
    context: context,
    enableDrag: true,
    isDismissible: true,
    isScrollControlled: false,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.w),
        topRight: Radius.circular(25.w),
      ),
    ),
    builder: (context) {
      return AnimatedPadding(
        padding: MediaQuery.of(context).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.bounceInOut,
        child: SizedBox(
          height: 350.h,
          child: widget ?? const SizedBox(),
        ),
      );
    },
  );
}
