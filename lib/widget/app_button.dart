// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remindly_app/utils/constants.dart';

class AppButton extends StatelessWidget {
  final String text;
  final String? isIcon;
  final Function()? onClick;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  final TextStyle? fontStyle;
  final Color? borderColor;
  final double? fontSize;

  final FontWeight? fontWeight;
  final double? minimumBtnWidth;
  final double? maximumBtnWith;
  final double? maxBtnHeight;
  final double? minBtnHeight;
  final String? fontFamily;
  final Function()? onclickCal;

  const AppButton({
    this.onclickCal,
    required this.text,
    required this.onClick,
    this.isIcon,
    this.borderRadius,
    this.color = Constant.primaryColor,
    this.borderColor,
    this.fontStyle,
    this.textColor,
    this.minBtnHeight,
    this.maxBtnHeight,
    this.fontWeight,
    this.fontFamily,
    this.minimumBtnWidth,
    this.maximumBtnWith,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return RawMaterialButton(
      highlightElevation: 5,
      constraints: BoxConstraints(
        minHeight: minBtnHeight ?? 52.h,
        maxHeight: maxBtnHeight ?? 52.h,
        maxWidth: maximumBtnWith ?? size.width,
        minWidth: minimumBtnWidth ?? size.width,
      ),
      onPressed: () => onClick?.call(),
      fillColor: color ?? Constant.secondaryColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius ?? 15.r),
        side: BorderSide(
          width: 1,
          color: borderColor ?? color!,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text.toString(),
            style: fontStyle ??
                TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 15.sp,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  fontFamily: fontFamily ?? "Quicksand",
                ),
          ),
          SizedBox(width:isIcon==null?0: 20.w,),
          isIcon==null?SizedBox():
          InkWell(
            onTap: onclickCal,
            child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child:Padding(
                  padding:  EdgeInsets.all(8.0.sp),
                  child: Image.asset(isIcon!,height: 17.h,width: 17.h,),
                )),
          ),
        ],
      ),
    );
  }
}

class IconAppButton extends StatelessWidget {
  final Widget? prefixIcon;

  final Function? onClick;
  final double borderRadius;
  final Color? textColor;
  final double fontSize;
  final bool isEnabled;
  final Color? btnTitleColor;
  final String imagePath;
  final Widget? iconWidget;
  final String? buttonTitle;
  final double? maxHeight, maxWidth, minWidth, minHeight;
  final Color? backgroundColor;
  final double? buttonFontSize;
  const IconAppButton({
    required this.onClick,
    this.borderRadius = 8,
    required this.imagePath,
    this.maxWidth,
    this.maxHeight,
    this.backgroundColor,
    this.minHeight,
    this.minWidth,
    this.buttonFontSize,
    this.iconWidget,
    this.btnTitleColor,
    this.textColor,
    this.fontSize = 15,
    this.isEnabled = true,
    required this.buttonTitle,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton.icon(
        label:

        Image.asset(
            imagePath,
            color: btnTitleColor ?? Colors.white,
        ),
        icon: iconWidget ?? Icon(Icons.add),
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: backgroundColor ?? Constant.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
          maximumSize: Size(maxWidth ?? size.width, maxHeight ?? 50.h),
          minimumSize: Size(minWidth ?? size.width, minHeight ?? 50.h),
        ),
        onPressed: isEnabled ? () => onClick?.call() : null);
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final Function? onClick;
  final double? borderRadius;
  final Color? color;
  final Color? textColor;
  final TextStyle? fontStyle;
  final Color? borderColor;
  final double? fontSize;
  final bool? isEnabled;
  final FontWeight? fontWeight;
  final double? minimumBtnWidth;
  final double? maximumBtnWith;
  final double? maxBtnHeight;
  final double? minBtnHeight;

  const AppOutlinedButton({
    required this.text,
    required this.onClick,
    this.borderRadius,
    this.color = Colors.white,
    this.borderColor = Constant.primaryColor,
    this.fontStyle,
    this.textColor =  Constant.primaryColor,
    this.minBtnHeight,
    this.maxBtnHeight,
    this.fontWeight,
    this.minimumBtnWidth,
    this.maximumBtnWith,
    this.fontSize,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        minimumSize: Size(minimumBtnWidth ?? size.width, minBtnHeight ?? 52.h),
        maximumSize: Size(maximumBtnWith ?? size.width, maxBtnHeight ?? 52.h),
        backgroundColor: color ??  Constant.primaryColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
            side: BorderSide(width: 1, color: borderColor ?? color!)),
      ),
      onPressed: () => onClick?.call(),
      child: Text(text,
          style: fontStyle ??
              TextStyle(
                  color: textColor ?? Colors.white,
                  fontSize: fontSize ?? 15.sp,
                  fontWeight: fontWeight ?? FontWeight.w700,
                  fontFamily:  "")),
    );
  }
}
