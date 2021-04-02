import 'package:get/get.dart';

import '../controllers/conformation_controller.dart';

class ConformationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConformationController>(
      () => ConformationController(),
    );
  }
}
