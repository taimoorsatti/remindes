import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:remindly_app/services/api/customer-support/customer_support_service.dart';
import 'package:remindly_app/services/firebase/firebase.dart';

class CustomerSupportController extends GetxController {
  TextEditingController titleController = TextEditingController();
  TextEditingController multiTextController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String email="";
  Rx<bool> isanu=true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateUser();


  }

  saveCustomerSupportInfo() async {
    try {
      FirebaseFirestore.instance
          .collection('users')
          .doc(firebaseAuth.currentUser!.uid)
          .get()
          .then((docSnapshot) {
            email=docSnapshot["email"].toString();
        print(email);
      });

      var res = await CustomerSupportService.saveCustomerSupport(
          content: multiTextController.text, email:email, subject:titleController.text);
      if (res.success == true) {
        Fluttertoast.showToast(
            msg: res.message.toString(), textColor: Colors.white);
        titleController.text="";
        multiTextController.text="";
      } else {
        log("failed to load data");
      }
    } catch (e) {
      log(e.toString());
    }
  }
  Future updateUser() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      emailController.text = value["email"];
      isanu.value = value["isAnonymous"];
    });
    update();
  }

}
