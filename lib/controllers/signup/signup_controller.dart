import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:remindly_app/models/login/login_model.dart';
import 'package:remindly_app/screens/event/event_view.dart';
import 'package:remindly_app/screens/login_signup/login/login_view.dart';
import 'package:remindly_app/services/localstorage/session_manager.dart';
import 'package:uuid/uuid.dart';

import '../../services/firebase/firebase.dart';
import '../../utils/assets_image_path.dart';
import '../../utils/constants.dart';
import '../../widget/app_button.dart';

class SignUpController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SessionManager _sessionManager = SessionManager();
  var uuid = Uuid();

  bool checkBoxValue = false;
  Timer? timer;

  checknonymous() async {
    if (_sessionManager.isUserLogin) {
      final credential = EmailAuthProvider.credential(
          email: emailController.text, password: passwordController.text);
      final userCredential = await FirebaseAuth.instance.currentUser
          ?.linkWithCredential(credential).catchError((msg){
            Fluttertoast.showToast(msg: " this email already in use " );
      });
      FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        "email": emailController.text.trim(),
        "name": nameController.text.trim(),
        "isAnonymous": false
      });
      Fluttertoast.showToast(msg: "Successfully Link to a permanent account. Verify from your email");
      Get.offNamed(LoginViewScreen.routeName);
    } else {
      createNewUser();
    }
  }

   createNewUser() async {
    try {
      final User? firebaseUser = (await firebaseAuth
              .createUserWithEmailAndPassword(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim())
              .catchError((msg) {
                print(msg);
       Get.snackbar("Remindes!", msg.message.toString(),backgroundColor: Colors.grey.withOpacity(0.5),colorText:Colors.black);
      }))
          .user;

      if (firebaseUser != null) {
        saveInfoNewUser();
        currentFireBaseUser = firebaseUser;

      } else {
        Fluttertoast.showToast(
            msg: "Registration failed", textColor: Colors.white);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signInWithGoogle() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
        await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        } else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    //checkUser(user!);
    currentFireBaseUser = user;
    return user;
  }

  saveInfoNewUser() async {
    String? fcmtoken = await FirebaseMessaging.instance.getToken();
    String? deviceId = await _getId();
    print(fcmtoken);
    _sessionManager.saveFCMToken(token: fcmtoken);

    Map<String, dynamic> token = {
      "deviceId": deviceId,
      "fcmtoken": fcmtoken,
    };
    List list = [token];
    Map<String, dynamic> call = {"expiryDate": "", "isEnabled": false};
    Map<String, dynamic> sms = {"expiryDate": "", "isEnabled": false};
    Map<String, dynamic> subscription = {"call": call, "sms": sms};
    Map<String, dynamic> userMap = {
      "userID": currentFireBaseUser?.uid,
      "name": nameController.text,
      "email": emailController.text,
      "token": FieldValue.arrayUnion(list),
      "isActive": false,
      "isDeleted":false,
      "isAnonymous": false,
      "subscription": subscription,
      "platform": "Android",
    };
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentFireBaseUser?.uid)
        .set(userMap);

    Fluttertoast.showToast(msg: "Successfully created. Verify from your email");
    Navigator.pushNamed(Get.context!, LoginViewScreen.routeName);
  }



  Future<void> anonymousSignIn() async {
    Get.dialog(
      Center(child: Lottie.asset('assets/gifs/Indicator-Dark.json', height: 150.sp, width: 150.sp)),
    );
    try {
    var res=  await FirebaseAuth.instance.signInAnonymously();
    print(res);
      currentFireBaseUser = FirebaseAuth.instance.currentUser;
      String? fcmtoken = await FirebaseMessaging.instance.getToken();
      String? deviceId = await _getId();
      print(fcmtoken);
      _sessionManager.saveFCMToken(token: fcmtoken);

      Map<String, dynamic> token = {
        "deviceId": deviceId,
        "fcmtoken": fcmtoken,
      };
      List list = [token];
      Map<String, dynamic> call = {"expiryDate": "", "isEnabled": false};
      Map<String, dynamic> sms = {"expiryDate": "", "isEnabled": false};
      Map<String, dynamic> subscription = {"call": call, "sms": sms};
      Map<String, dynamic> userMap = {
        "userID": currentFireBaseUser?.uid,
        "name": "",
        "email": "",
        "token": FieldValue.arrayUnion(list),
        "isActive": true,
        "isAnonymous": true,
        "isDeleted":false,
        "subscription": subscription,
        "platform": "Android",
      };
      FirebaseFirestore.instance
          .collection('users')
          .doc(currentFireBaseUser?.uid)
          .set(userMap);
      Get.back();

      showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return showDialogIfNotConnect();
          });

    } catch (e) {
      log("error");
    }
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    var androidDeviceInfo = await deviceInfo.androidInfo;
    return androidDeviceInfo.androidId; // unique ID on Android
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
      child: Padding(
        padding: EdgeInsets.only(top: 15.0.sp,bottom: 15.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Success",style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 24.sp,
              color: Colors.black,
              fontFamily: "Quicksand",
              fontWeight: FontWeight.bold,
            ),),
            Text(
              "Your Guest account has been successfully created",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.black,
                decoration: TextDecoration.none,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
              ),
            ),
            Container(
              height: 1.h,
              width: double.infinity,
              color: Constant.colorTextFieldeBorder,
            ),
            InkWell(
              onTap: (){
                Get.offNamed(EventScreen.routeName);
              },
              child: Text("OKay",style: TextStyle(
                fontSize: 16.sp,
                decoration: TextDecoration.none,
                color: Constant.primaryColor,
                fontFamily: "Quicksand",
                fontWeight: FontWeight.w600,
              ),
              ),
            )
          ],
        ),
      ),
    ));
  }


   validateEmail({required String email,required String name, required String password}) {
    if (!GetUtils.isEmail(email)) {
      Fluttertoast.showToast(
          msg: "   please Enter a valid email  ", backgroundColor: Colors.black);
    }
      else if(name.isEmpty) {
      Fluttertoast.showToast(
          msg: "   name field required  ", backgroundColor: Colors.black);
    }
    else if(checkBoxValue==false) {
      Fluttertoast.showToast(
          msg: "   accept the term of use and privacy policy  ", backgroundColor: Colors.black);
    }
      else if(password.length<8){
      Fluttertoast.showToast(
          msg: "   password length must be grater then 7  ", backgroundColor: Colors.black);
    } else {
      checknonymous();
    }
  }

}
