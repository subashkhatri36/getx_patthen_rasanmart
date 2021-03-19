import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  //RxInt navSelectedIndex = 0.obs;
  RxBool searchBar = false.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void showSearchBar(bool value) => searchBar.value = value;
}
