import 'package:get/get.dart';

import '../controllers/conformdelivery_controller.dart';

class ConformdeliveryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConformdeliveryController>(
      () => ConformdeliveryController(),
    );
  }
}
