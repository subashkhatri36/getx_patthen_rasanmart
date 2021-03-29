import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';

class ProductCategoryController extends GetxController {
  final productCat = Get.find<HomeController>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    productCat.subcategorypage.value = true;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    productCat.subcategorypage.value = false;
  }

  void increment() => count.value++;
}
