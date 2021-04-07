import 'package:get/get.dart';

import '../controllers/orderdetails_controller.dart';

class OrderdetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderdetailsController>(
      () => OrderdetailsController(),
    );
  }
}
