import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/notificationpage/controllers/notification_controller.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';

class SplashController extends GetxController {
  final splashDelay = 3;
  final String versionName = 'V1.0'.obs();

//  final logInfo = Get.put(AccountController());

  @override
  void onInit() {
    _loadWidget();
    Get.put(CartController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    Get.put(DeliveryController());
    // if (authcontroller.firebaseAuth.currentUser != null)
    // logInfo.isLogOut.value = false;

    super.onInit();
  }

  _loadWidget() async {
    var _duration = Duration(seconds: splashDelay);
    return Timer(_duration, navigation);
  }

  void navigation() {
    if (FirebaseAuth.instance.currentUser != null) {
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
