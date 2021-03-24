import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainauthController>(
      () => MainauthController(),
    );
    Get.lazyPut<AuthenticationController>(
      () => AuthenticationController(),
    );
  }
}
