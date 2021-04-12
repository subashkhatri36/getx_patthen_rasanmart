import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetpasswordController extends GetxController {
  TextEditingController forgetController = new TextEditingController();
  GlobalKey<FormState> reset = new GlobalKey<FormState>();

  RxBool resetpassword = true.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> resetPassword() async {
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: forgetController.text)
        .whenComplete(() => resetpassword.value = true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    forgetController.dispose();
  }
}
