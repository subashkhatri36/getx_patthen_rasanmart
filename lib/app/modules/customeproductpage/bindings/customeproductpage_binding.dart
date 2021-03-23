import 'package:get/get.dart';

import 'package:rasan_mart/app/modules/customeproductpage/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/category_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/product_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/scrollbanner_controller.dart';

import '../controllers/customeproductpage_controller.dart';

class CustomeproductpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CartController>(
      () => CartController(),
    );
    Get.lazyPut<ProductController>(
      () => ProductController(),
    );
    Get.lazyPut<ScrollbannerController>(
      () => ScrollbannerController(),
    );
    Get.lazyPut<CategoryController>(
      () => CategoryController(),
    );
    Get.lazyPut<CustomeproductpageController>(
      () => CustomeproductpageController(),
    );
  }
}
