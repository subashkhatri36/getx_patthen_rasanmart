import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/customeproductpage/categories_model.dart';

class CategoryController extends GetxController {
  //TODO: Implement CategoryController

  RxList<Categories> categories;
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  fetchCategories() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
