import 'package:get/get.dart';

import '../controllers/notificationpage_controller.dart';

class NotificationpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationpageController>(
      () => NotificationpageController(),
    );
  }
}
