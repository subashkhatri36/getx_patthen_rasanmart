import 'package:get/get.dart';

import '../controllers/productview_controller.dart';

class ProductviewBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProductviewController>(
      () => ProductviewController(),
    );
  }
}
