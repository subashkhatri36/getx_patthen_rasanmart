import 'package:get/get.dart';

import '../controllers/deliveryviewall_controller.dart';

class DeliveryviewallBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeliveryviewallController>(
      () => DeliveryviewallController(),
    );
  }
}
