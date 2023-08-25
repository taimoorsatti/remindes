
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';




abstract class Constant {



  static const primaryColor = Color(0xff339CE9);

  static const secondaryColor = Color(0xff1D5BDF);
  static const textColorDark = Color(0xffFFFFFF);
  static const backgroundColor = Color(0xffF3F3F3);
  static const Color colorTextFieldeBorder = Color(0xffC7CFDC);
  static const Color colorBorder = Color(0xffB7B1B1);
  static const Color profileLightText = Color(0xff8B8B8B);
  static const Color blueLightText = Color(0xff36308b);









  static TextStyle smallTextStyle({double? fontSize, Color? textColor}) =>
      TextStyle(
        color: textColor ?? Constant.primaryColor,
        fontWeight: FontWeight.w400,
        fontSize: fontSize ?? 12.sp,
        fontFamily: "",
      );


  static TextStyle mediumTextStyle({double? fontSize, Color? textColor}) =>
      TextStyle(
        color: textColor ?? Constant.primaryColor,
        fontWeight: FontWeight.w500,
        fontSize: fontSize ?? 14.sp,
        fontFamily: "",
      );


  static TextStyle semiBoldTextStyle({double? fontSize, Color? textColor}) =>
      TextStyle(
        color: textColor ?? Constant.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 14.sp,
        fontFamily: "",
      );


  static TextStyle boldTextStyle({double? fontSize, Color? textColor}) =>
      TextStyle(
        color: textColor ?? Constant.primaryColor,
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? 16.sp,
        fontFamily: "",
      );

}
