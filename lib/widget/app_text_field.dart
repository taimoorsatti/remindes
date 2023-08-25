import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:remindly_app/utils/constants.dart';



class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    this.prefixIcon,
    this.suffixIcon,
    required this.hint,
    this.maxLine,

    required this.textInputType,
    required this.textInputAction,
    this.isObscure = false,
    this.controller,
    this.onChanged,
    this.readOnly,
    this.isFilled,
    this.filledColor,
    this.marginBottom,
    this.minimumHeight,
    this.maximumHeight,
    this.onTap,
    this.autoFocus,
    this.isEnabled = true,
    this.validator,
   this.title,
  this.anbale,
    this.labelText,
  this.titleStyle
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final String hint;
  final int? maxLine;
  final TextInputType textInputType;
  final bool? isEnabled;

  final TextInputAction? textInputAction;
  final bool? isObscure;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final bool? readOnly;
  final bool? isFilled;
  final Color? filledColor;
  final double? marginBottom;
  final double? minimumHeight;
  final bool? anbale;
  final double? maximumHeight;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title??"",style: titleStyle?? const TextStyle(
          fontSize: 20,
          fontWeight:FontWeight.bold,
          fontFamily: "Quicksand",
          color: Constant.primaryColor,
        ),),
        SizedBox(height: 10.h,),
        TextFormField(
          onTap: onTap,
          obscureText: isObscure ?? false,
          controller: controller,
          readOnly: readOnly ?? false,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLine ?? 1,
          keyboardType: textInputType,
          enabled: isEnabled ?? true,
          textInputAction: textInputAction,
          style: TextStyle(
            color: Constant.blueLightText,
            fontFamily: "Quicksand",
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
          autofocus: autoFocus ?? false,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(
            //   0,
            // ),
            alignLabelWithHint: true,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color:Colors.grey,width: 1)
           ),
            errorBorder:  const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red,width: 1)
            ),
            border:  const UnderlineInputBorder(
                borderSide: BorderSide( color:Constant.textColorDark,width: 1)
            ),
            constraints: BoxConstraints(
              minHeight: minimumHeight ?? 52.h,
              maxHeight: maximumHeight ?? 52.h,
            ),
            disabledBorder:const UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.black,width: 1)
            ),
            suffixIcon: suffixIcon,
            prefixIconConstraints: prefixIcon == null
                ? const BoxConstraints(minWidth: 16, minHeight: 0)
                : const BoxConstraints(minWidth: 16, minHeight: 16),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: prefixIcon ?? const SizedBox(),
            ),
            fillColor: filledColor ?? Colors.transparent,
            filled: isFilled ?? false,
            focusedBorder:   const UnderlineInputBorder(
                borderSide: BorderSide(color:Constant.secondaryColor,width: 1)
            ),
            enabled: anbale??true,

            hintText: hint,
            hintStyle:  TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w400,
                fontFamily: "Quicksand",
                color: Colors.grey.withOpacity(1),
            ),
          ),
        ),
      ],
    );
  }
}



class AppTextFieldSocial extends StatelessWidget {
  const AppTextFieldSocial({
  super.key,
  this.prefixIcon,
  this.suffixIcon,
  required this.hint,
  this.maxLine,

  required this.textInputType,
  required this.textInputAction,
  this.isObscure = false,
  this.controller,
  this.onChanged,
  this.readOnly,
  this.isFilled,
  this.filledColor,
  this.marginBottom,
  this.minimumHeight,
  this.maximumHeight,
  this.onTap,
  this.onTapperfix,
  this.autoFocus,
  this.isEnabled = true,
  this.validator,
  this.title,
  this.anbale,
  this.labelText,
  this.titleStyle
  });

  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? title;
  final String hint;
  final int? maxLine;
  final TextInputType textInputType;
  final bool? isEnabled;

  final TextInputAction? textInputAction;
  final bool? isObscure;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onTapperfix;
  final bool? readOnly;
  final bool? isFilled;
  final Color? filledColor;
  final double? marginBottom;
  final double? minimumHeight;
  final bool? anbale;
  final double? maximumHeight;
  final bool? autoFocus;
  final String? Function(String?)? validator;
  final String? labelText;
  final TextStyle? titleStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title??"",style: titleStyle??  TextStyle(
          fontSize: 20.sp,
          fontWeight:FontWeight.bold,
          fontFamily: "Quicksand",
          color: Constant.primaryColor,
        ),),
        SizedBox(height: 10.h,),
        TextFormField(
          onTap: onTap,
          obscureText: isObscure ?? false,
          controller: controller,
          readOnly: readOnly ?? false,
          validator: validator,
          onChanged: onChanged,
          maxLines: maxLine ?? 1,
          keyboardType: textInputType,
          enabled: isEnabled ?? true,
          textInputAction: textInputAction,
          style: TextStyle(
              color: Constant.blueLightText,
              fontFamily: "Quicksand",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
          ),
          autofocus: autoFocus ?? false,
          decoration: InputDecoration(
            // contentPadding: EdgeInsets.all(
            //   0,
            // ),
            alignLabelWithHint: true,
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.grey,width: 1)
            ),
            errorBorder:  const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red,width: 1)
            ),
            border:  const UnderlineInputBorder(
                borderSide: BorderSide( color:Constant.textColorDark,width: 1)
            ),
            constraints: BoxConstraints(
              minHeight: minimumHeight ?? 52.h,
              maxHeight: maximumHeight ?? 52.h,
            ),
            disabledBorder:const UnderlineInputBorder(
                borderSide: BorderSide(color:Colors.black,width: 1)
            ),
            suffixIcon: suffixIcon,
            prefixIconConstraints: prefixIcon == null
                ? const BoxConstraints(minWidth: 16, minHeight: 0)
                : const BoxConstraints(minWidth: 16, minHeight: 16),
            prefixIcon: InkWell(
              onTap:onTapperfix,
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: prefixIcon ?? const SizedBox(),
              ),
            ),
            fillColor: filledColor ?? Colors.transparent,
            filled: isFilled ?? false,
            focusedBorder:   const UnderlineInputBorder(
                borderSide: BorderSide(color:Constant.secondaryColor,width: 1)
            ),
            enabled: anbale??true,

            hintText: hint,
            hintStyle:  TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w400,
              fontFamily: "Quicksand",
              color: Colors.grey.withOpacity(1),
            ),
          ),
        ),
      ],
    );
  }
}
