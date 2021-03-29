import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/home/controllers/notification_controller.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  //RxInt navSelectedIndex = 0.obs;
  ScrollController scrollController = new ScrollController();
  ScrollController scrollController1 = new ScrollController();
  RxBool searchBar = false.obs;
  RxDouble _scrollPosition = 0.0.obs;
  RxBool isCartClick = false.obs;
  RxBool subcategorypage = false.obs;

  @override
  void onInit() {
    Get.put(CartController(), permanent: true);
    Get.put(NotificationController(), permanent: true);
    subcategorypage.value = false;
    scrollController.addListener(_scrollListener);
    super.onInit();
  }

  _scrollListener() {
    if (!subcategorypage.value) {
      _scrollPosition.value = scrollController.position.pixels;
      if (_scrollPosition > 75) {
        Get.find<HomeController>().searchBar.value = true;
      } else {
        Get.find<HomeController>().searchBar.value = false;
      }
    }
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
