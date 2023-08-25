import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/signin/signin_controller.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../../../widget/app_text_field.dart';
import '../../../controllers/customer_support/customer_support_conteroller.dart';
import '../../../utils/constants.dart';

class CustomerTitle extends StatelessWidget {

  CustomerTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return   AppTextField(
      controller: Get.find<CustomerSupportController>().titleController,
      hint: "Enter title...",
      title: "Title",
      titleStyle:  TextStyle(

        fontSize: 14.sp,
        fontWeight:FontWeight.bold,
        fontFamily: "Quicksand",
        color: Constant.primaryColor,
      ),
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      //validator: RequiredValidator(errorText: 'Please Enter your email'),
    );
  }

}

class EmailTextFieldSupport extends StatelessWidget {
  EmailTextFieldSupport({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Obx(
        ()=>
         AppTextField(
          isEnabled:Get.find<CustomerSupportController>().isanu.value?true:false,
          hint: "Enter your email...",
          titleStyle:  TextStyle(
            fontSize: 16.sp,
            fontWeight:FontWeight.bold,
            fontFamily: "Quicksand",

            color: Constant.primaryColor,
          ),
          controller: Get.find<CustomerSupportController>().emailController,
          title: "Email",
          textInputType: TextInputType.text,
          textInputAction: TextInputAction.next,
          //validator: RequiredValidator(errorText: 'Please Enter your email'),
        ),
      );

  }
}

