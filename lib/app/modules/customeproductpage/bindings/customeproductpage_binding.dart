import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/customeproductpage/controllers/category_controller.dart';

import '../controllers/customeproductpage_controller.dart';

class CustomeproductpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<CustomeproductpageController>(
      () => CustomeproductpageController(),
    );
  }
}
