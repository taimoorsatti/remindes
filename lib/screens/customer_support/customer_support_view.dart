import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remindly_app/controllers/customer_support/customer_support_conteroller.dart';

import '../../controllers/checkinternet/checkinternet_controller.dart';
import '../../utils/assets_image_path.dart';
import '../../utils/constants.dart';
import '../../widget/app_button.dart';
import '../../widget/multiple_text.dart';
import '../login_signup/login/components/Textfield.dart';
import '../setting/components/editprofile/componets/textfield.dart';
import 'components/textfield.dart';

class CustomerSupport extends StatelessWidget {
  static const routeName="/customersupport";
   CustomerSupport({Key? key}) : super(key: key);
  CustomerSupportController customerSupportController=Get.put(CustomerSupportController());
   CheckConnectionStream checkConnectionStream = Get.put(CheckConnectionStream());

  @override
  Widget build(BuildContext context) {
    Get.find<CustomerSupportController>().updateUser();
    var mySystemTheme = SystemUiOverlayStyle.light.copyWith(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        statusBarColor: Constant.primaryColor,
        systemNavigationBarIconBrightness: Brightness.dark
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Scaffold(
      backgroundColor: Constant.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                decoration:  const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Constant.primaryColor,
                        Constant.secondaryColor,
                      ],
                    )),
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0.sp,right: 10.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h,),
                      InkWell(
                        onTap: (){
                          Get.back();
                        },
                        child: Container(
                          child: Image.asset(AppAssets.backArrowPic, color: Color(0xff36308b),height: 45.h,width: 45.h,),
                        ),
                      ),
                      SizedBox(height: 20.sp,),
                      Text(
                        "Customer Support",
                        textAlign: TextAlign.start,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.sp,
                            fontFamily: "Quicksand",
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.76,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Constant.secondaryColor,
                        Constant.secondaryColor,
                      ],
                    )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.76,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(15),
                      topLeft: Radius.circular(15),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0.sp),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        EmailTextFieldSupport(),
                        SizedBox(height: 20.h),
                        CustomerTitle(),
                        SizedBox(height: 20.h),
                         MultilineTextField(
                          mycontroler:Get.find<CustomerSupportController>().multiTextController,
                          hintText: "Describe here",
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.r),
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Constant.primaryColor,
                                  Constant.secondaryColor,
                                ],
                              )),
                          child: AppButton(
                            fontFamily: "Quicksand",
                            minBtnHeight: 60.h,
                            borderRadius: 25.r,
                            maxBtnHeight: 60.h,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            text: 'Submit',
                            onClick: () {
                              FocusScope.of(context).unfocus();
                              if(customerSupportController.titleController.text.isEmpty||customerSupportController.multiTextController.text.isEmpty){
                                Fluttertoast.showToast(msg: "  field empty  ");
                              }
                              else{
                                customerSupportController.saveCustomerSupportInfo();

                              }

                            },
                            color: Colors.transparent,
                            textColor: Constant.backgroundColor,
                          ),
                        ),
  ]
                    )
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
