import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/home/controllers/notification_controller.dart';
import 'package:rasan_mart/app/modules/home/controllers/productcontainercontroller_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(
      () => NotificationController(),
    );
    Get.lazyPut<ProductcontainercontrollerController>(
      () => ProductcontainercontrollerController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
