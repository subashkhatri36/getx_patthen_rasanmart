import 'package:get/get.dart';

import '../controllers/otpverification_controller.dart';

class OtpverificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpverificationController>(
      () => OtpverificationController(),
    );
  }
}
