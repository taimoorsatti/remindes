import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';
import 'package:remindly_app/models/setting/setting_model.dart';
import 'package:remindly_app/screens/login_signup/login/login_view.dart';
import 'package:remindly_app/screens/login_signup/signup/signup_view.dart';
import 'package:remindly_app/screens/setting/components/editprofile/editprofile.dart';
import 'package:remindly_app/services/firebase/firebase.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:remindly_app/utils/assets_image_path.dart';

import '../../screens/customer_support/customer_support_view.dart';
import '../../screens/event/event_view.dart';
import '../../screens/setting/components/changepassword/changepassword.dart';
import '../../screens/setting/components/privacy_policy/privacy_policy_view.dart';
import '../../screens/setting/components/subscription/subscription_view.dart';
import '../../utils/constants.dart';
import '../../widget/terms_policy.dart';

class SettingController extends GetxController {
  List<SettingModel> listSettingModel = <SettingModel>[].obs;
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  final nameController = TextEditingController().obs;
  final emailController = TextEditingController().obs;
  dynamic isAnonymous = false;
  Rx<bool> isLoading=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  checkAnonymous() async {
    try {
      isLoading.value=true;
    await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        isAnonymous = value["isAnonymous"];
        addList(isAnonymous);
      });
    } catch (e) {
      print(e);
    }
    update();
  }

  void addList(bool isAnonymous) {
    listSettingModel = [];
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.userPic, name: "Edit Profile"),
    );
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.padlockPic, name: "Change Password"),
    );
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.subscriptionPic, name: "Subscription"),
    );
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.informationPic, name: "Terms & Policy"),
    );
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.questionPic, name: "Help"),
    );
    listSettingModel.add(
      isAnonymous == true
          ? SettingModel(
          imageUrl: AppAssets.signIcon, name: "Link to a permanent account")
          : SettingModel(imageUrl: AppAssets.switchPic, name: "Logout"),
    );
    isAnonymous == true ?
    listSettingModel.add(
      SettingModel(imageUrl: AppAssets.switchPic, name: "Logout"),
    ) : Container();
      isLoading.value=false;
  }
  switchPage({int? index, BuildContext? context}) async {
    switch (index) {
      case 0:
        isAnonymous
            ? Fluttertoast.showToast(
                msg: "Anonymous account can't update profile")
            : Navigator.push(
                Get.context!,
                PageTransition(
                  type: PageTransitionType.rightToLeft,
                  child: EditProfileScreen(),
                ),
              );
        break;
      case 1:
        {
          isAnonymous
              ? Fluttertoast.showToast(
              msg: "Anonymous account can't change password")
              :
          Navigator.push(
            Get.context!,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: ChangePassword(),
            ),
          );
          break;
        }
      case 2:
        {
          Navigator.push(
            Get.context!,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: SubsriptionScreen(),
            ),
          );
          break;
        }
      case 3:
        {
          showDialog(
              context: context!,
              builder: (BuildContext context) {
                return TermsPolicy();
              });
          break;
        }
      case 4:
        Navigator.push(
          Get.context!,
          PageTransition(
            type: PageTransitionType.rightToLeft,
            child: CustomerSupport(),
          ),
        );
        break;
      case 5:
        {
          if (isAnonymous) {
            showDialog(
                context: context!,
                builder: (BuildContext context) {
                  return showDialoglinkEmail();
                });

          } else {

            String? deviceId = await _getId();

            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get()
                .then((value) {
              List fcmToken = value["token"];
              fcmToken.forEach((element) {
                var devid = element["deviceId"];
                if (devid == deviceId) {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .update({
                    'token': FieldValue.arrayRemove([element])
                  });

                  SessionManager().clearSession();
                  FirebaseAuth.instance.signOut();
                  Get.to(LoginViewScreen());
                  Fluttertoast.showToast(msg: " account Logout successfully ",backgroundColor: Colors.black);
                }
              });
            });
          }
          break;
        }
      case 6:
        {
          showDialog(
              context: context!,
              builder: (BuildContext context) {
                return showDialogdeleteAccount();
              });
          break;
        }
      default:
        {
          print("");
        }
        break;
    }
  }

  Future<bool> changePassword(
      String currentPassword, String newPassword) async {
    bool success = false;

    //Create an instance of the current user.
    var user = await FirebaseAuth.instance.currentUser!;

    final cred = await EmailAuthProvider.credential(
        email: user.email!, password: currentPassword);
    await user.reauthenticateWithCredential(cred).then((value) async {
      await user.updatePassword(newPassword).then((_) {
        success = true;
        Fluttertoast.showToast(msg: "Update successfully");
      }).catchError((error) {
        Get.snackbar(
          "Remindes",
          "Password invalid",
        );
        return;
      });
    }).catchError((err) {
      Get.snackbar("Remindes", "Password invalid");
      return;
    });

    return success;
  }

  Future updateUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      nameController.value.text = value["name"];
      emailController.value.text = value["email"];
    });
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }

  showDialoglinkEmail() {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child:Container(
          height: 180.h,
          width: Get.width - 70.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0.sp),
                child: Text("Alert",style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Padding(
                padding:  EdgeInsets.all(10.sp),
                child: Text(
                  "For link account, please use an email which doesn't have any account on this app.",

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Column(
                children: [
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    color: Constant.colorTextFieldeBorder,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Text("Cancel",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          backgroundColor: Colors.white,
                          color: Constant.secondaryColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Container(
                        height: 40.h,
                        width: 1.w,
                        color: Constant.colorTextFieldeBorder,
                      ),
                      InkWell(
                        onTap: (){
                          Get.to(SignUpView());
                        },
                        child: Text("Continue",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          color: Constant.secondaryColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),),
                      ),

                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
  showDialogdeleteAccount() {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child:Container(
          height: 180.h,
          width: Get.width - 70.w,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10.0.sp),
                child: Text("Alert",style: TextStyle(
                  decoration: TextDecoration.none,
                  fontSize: 24.sp,
                  color: Colors.black,
                  fontFamily: "Quicksand",
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Padding(
                padding:  EdgeInsets.all(10.sp),
                child: Text(
                  "guest user data will be permanently deleted.",

                  textAlign: TextAlign.center,
                  style: TextStyle(
                    decoration: TextDecoration.none,
                    fontSize: 14.sp,
                    color: Colors.black,
                    fontFamily: "Quicksand",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Column(
                children: [
                  Container(
                    height: 1.h,
                    width: double.infinity,
                    color: Constant.colorTextFieldeBorder,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [

                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Text("Cancel",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          backgroundColor: Colors.white,
                          color: Constant.secondaryColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.bold,
                        ),),
                      ),
                      Container(
                        height: 40.h,
                        width: 1.w,
                        color: Constant.colorTextFieldeBorder,
                      ),
                      InkWell(
                        onTap: ()async{
                          await FirebaseFirestore.instance
                              .collection("users")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .delete();
                          await FirebaseFirestore.instance
                              .collection("events")
                              .doc(FirebaseAuth.instance.currentUser!.uid)
                              .delete();
                          FirebaseAuth.instance.currentUser!.delete();
                          SessionManager().clearSession();
                          Fluttertoast.showToast(msg: " account deleted ");
                          Get.to(LoginViewScreen());
                        },
                        child: Text("Continue",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          color: Constant.secondaryColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),),
                      ),

                    ],
                  )
                ],
              )
            ],
          ),
        ));
  }
}
