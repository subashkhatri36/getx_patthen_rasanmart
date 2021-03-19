import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/home/controllers/productcontainercontroller_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductcontainercontrollerController>(
      () => ProductcontainercontrollerController(),
    );
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
