import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
  }
}
