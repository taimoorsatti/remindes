import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:remindly_app/services/firebase/firebase.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:uuid/uuid.dart';

import '../../screens/event/event_view.dart';
import '../../utils/constants.dart';

class SignInController extends GetxController {
  final BuildContext? context;
  SignInController({this.context});
  TextEditingController restpasswordController = TextEditingController();
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();
  SessionManager sessionManager = SessionManager();
  bool isShowPassword = true;
  var uuid = Uuid();
  Rx<bool> isEmailVerified = false.obs;
  bool isLoading=false;
  Timer? timer;
  bool isDeleted=false;

  @override
  void onInit() {

    // TODO: implement onInit
    super.onInit();
    restpasswordController.text = "";
    emailLoginController.text = "";
    passwordLoginController.text = "";
  }

  Future resetPassword() async {
    if (restpasswordController.text.isNotEmpty) {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: restpasswordController.text);
    }
  }




  Future<bool> checkDeleted()async{
   await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
       isDeleted = value["isDeleted"];
      });
   update();
   return isDeleted;

  }


  Login() async {
    try {
      isLoading=true;
      Get.dialog(
        Center(child: Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp)),
      );
      final User? firebaseuser = (await firebaseAuth
              .signInWithEmailAndPassword(
                  email: emailLoginController.text.trim(),
                  password: passwordLoginController.text.trim())
              .catchError((msg) {
                print(msg.message);
        Fluttertoast.showToast(
            msg: msg.message,
            textColor: Colors.white);
        Get.back();

        //Get.to(SignUpViewcreen());
      }))
          .user;

      if (firebaseuser != null) {
    checkDeleted().whenComplete((){
      if(isDeleted){
        Fluttertoast.showToast(msg: "This account has been deleted, If you want to get back your account please contact us.");
        Get.back();
      }
      else{
        if(FirebaseAuth.instance.currentUser!.emailVerified){
          Get.offAllNamed(EventScreen.routeName);
          updateToken();
        }else{
          firebaseuser.sendEmailVerification();
          Get.back();
          showDialog(
              context: Get.context!,
              builder: (BuildContext context) {
                return showDialogIfNotConnect();
              });
          timer = Timer.periodic(
              const Duration(seconds: 3), (_) => checkEmailVerified());
          updateToken();
          isLoading=false;
        }

      }
    });





      } else {
        firebaseAuth.signOut();
        Fluttertoast.showToast(
            msg: "No record exits for this User. please create new account",
            textColor: Colors.white);
        isLoading=false;
        Navigator.pop(context!);
      }
    } catch (e) {
      log(e.toString());
      isLoading=false;
    }
  }


  checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser?.reload();
    isEmailVerified.value = FirebaseAuth.instance.currentUser!.emailVerified;

    if (isEmailVerified.value) {
      timer!.cancel();
      Get.offAllNamed(EventScreen.routeName);
    }

  }

  updateToken() async {
    String? deviceId = await _getId();
    String? token = await FirebaseMessaging.instance.getToken();
    Map<String, dynamic> tokenrray = {
      "deviceId": deviceId,
      "fcmtoken": token,
    };
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      List fcmToken = value["token"];
      print(fcmToken.length);
      if (fcmToken.length != 0) {
        fcmToken.forEach((element) {
          var devid = element["deviceId"];
          if (devid == deviceId) {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "token": [
                {"fcmtoken": token, "deviceId": deviceId}
              ],
              "isActive":true
            });
          } else {
            FirebaseFirestore.instance
                .collection("users")
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .update({
              "token": FieldValue.arrayUnion([tokenrray]),
              "isActive":true
            });
          }
        });
      } else {
        FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .update({
          "token": FieldValue.arrayUnion([tokenrray]),
          "isActive":true
        });
      }
    });
    saveUser(token.toString(), deviceId.toString());
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
  }

  saveUser(String token, String id) {
    sessionManager.saveFCMToken(token: token);
    sessionManager.saveRiderId(riderId: id);
  }
  showDialogIfNotConnect() {
    return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child:Container(
          height: 150.h,
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
                padding:  EdgeInsets.only(bottom: 10.0.sp),
                child: Text(
                  "Verify your email by verification link sent on your email.",

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
                        child: Text("Okay",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          backgroundColor: Colors.white,
                          color: Constant.primaryColor,
                          fontFamily: "Quicksand",
                          fontWeight: FontWeight.w600,
                        ),),
                      ),
                      Container(
                        height: 40.h,
                        width: 1.w,
                        color: Constant.colorTextFieldeBorder,
                      ),
                      InkWell(
                        onTap: (){
                          FirebaseAuth.instance.currentUser!.sendEmailVerification();
                        },
                        child: Text("Resend",style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 16.sp,
                          color: Constant.primaryColor,
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


  validateEmail({required String email, required String password}) {
    if (!GetUtils.isEmail(email)) {
      Fluttertoast.showToast(
          msg: "   please Enter a valid email  ", backgroundColor: Colors.black);
    }

    else if(password.length<8){
      Fluttertoast.showToast(
          msg: "   password length must be grater then 7  ", backgroundColor: Colors.black);
    } else {
      Login();
    }
  }
}
