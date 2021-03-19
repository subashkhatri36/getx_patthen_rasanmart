import 'package:get/get.dart';

import '../controllers/nointernet_controller.dart';

class NointernetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NointernetController>(
      () => NointernetController(),
    );
  }
}
