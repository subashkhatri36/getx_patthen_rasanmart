import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/search/search_repository.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/searchpage/providers/searchpage_provider.dart';

class SearchpageController extends GetxController {
  RxList<Product> productsearch;
  RxList<Product> productsearchtemp;
  ScrollController searchscroll = new ScrollController();
  TextEditingController textEditingController = new TextEditingController();
  SearchpageProvider searchrepository = SearchRepository();

  RxInt count = 10.obs;
  @override
  void onInit() {
    super.onInit();
    textEditingController.addListener(() {
      if (textEditingController.text.length > 3) {
        doSearch(textEditingController.text);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  Future<void> doSearch(String text) async {
    List<Product> mainlist = [];
    Either<String, List<Product>> result =
        await searchrepository.fetchingProductWithTags(text);
    result.fold((l) {
      print(l);
    }, (r) {
      mainlist = r?.toList();
      productsearch = mainlist.obs;
      print(mainlist.length);
    });
  }
  //List<Product> serch

  @override
  void onClose() {}
  void increment() => count.value++;
}
