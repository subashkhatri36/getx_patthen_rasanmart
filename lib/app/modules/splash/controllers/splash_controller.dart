import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';

class SplashController extends GetxController {
  final splashDelay = 1;
  final String versionName = 'V1.0'.obs();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance.obs();
  UserCredential userCredential = null.obs();
  String userId = ''.obs();

  @override
  void onInit() {
    _loadWidget();
    super.onInit();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigation);
  }

  void navigation() {
    if (firebaseAuth.currentUser != null) {
      Get.off(() => HomeView());
    } else {
      Get.off(() => AuthenticationView());
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
