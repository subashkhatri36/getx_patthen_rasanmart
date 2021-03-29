import 'dart:async';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';

class SplashController extends GetxController {
  final splashDelay = 3;
  final String versionName = 'V1.0'.obs();
  final authcontroller = Get.put(MainauthController(), permanent: true);

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
    if (authcontroller.firebaseAuth.currentUser != null) {
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
