import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/search/search_repository.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/searchpage/providers/searchpage_provider.dart';

class SearchpageController extends GetxController {
  RxList<Product> productsearch;

  TextEditingController textEditingController = new TextEditingController();
  SearchpageProvider searchrepository = SearchRepository();

  RxInt count = 10.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();
    textEditingController.addListener(() {
      if (textEditingController.text.length == 0) {
        if (productsearch.length > 0) productsearch.clear();
      }
     // if (textEditingController.text.length > 3) doSearch();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> doSearch() async {
    isLoading.toggle();
    List<Product> mainlist = [];
    if (textEditingController.text.length > 0) {
      Either<String, List<Product>> result = await searchrepository
          .fetchingProductWithTags(textEditingController.text);
      result.fold((l) {
        print(l);
        print('Data Failed');
      }, (productlist) {
        mainlist = productlist?.toList();
        productsearch = mainlist.obs;
      });
      isLoading.toggle();
    }
  }
  //List<Product> serch

  @override
  void onClose() {
    textEditingController.dispose();
  }

  void increment() => count.value++;
}
