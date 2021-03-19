import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/Product/product_container_repositories.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';

class CustomeproductpageController extends GetxController {
  final categories = 'Home'.toUpperCase().obs;
  RxList<ProductContianer> productContianerList;
  RxBool isProductContianerLioading = false.obs;

  RxInt index = 0.obs;
  ScrollController scrollController = new ScrollController();
  RxDouble _scrollPosition = 0.0.obs;

  ProductContianerRepo _productContainerRepo =
      new ProductContianerRepositories();

  @override
  void onInit() {
    scrollController.addListener(_scrollListener);
    loadproductContianer();
    super.onInit();
  }

  _scrollListener() {
    _scrollPosition.value = scrollController.position.pixels;
    if (_scrollPosition > 75) {
      Get.find<HomeController>().searchBar.value = true;
    } else {
      Get.find<HomeController>().searchBar.value = false;
    }
  }

  void loadproductContianer() async {
    print('Loading product container');
    isProductContianerLioading.toggle();
    Either<String, List<ProductContianer>> containerValue =
        await _productContainerRepo.fetchOnlineProductContianer(
            category: categories.value);
    containerValue.fold((l) {
      print(l);
      productContianerList =
          _productContainerRepo.fetchOfflineProductContianer().toList().obs;
    }, (r) => productContianerList = r.toList().obs);
    isProductContianerLioading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void changeCategories(String category) =>
      categories.value = category.toUpperCase();
}
