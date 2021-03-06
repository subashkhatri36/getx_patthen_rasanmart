import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/Product/product_repositories.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/product_provider.dart';

class GridviewController extends GetxController {
  // RxList<List<Product>> productlist;
  ProductRepo productRepo = new ProductRepositories();
  RxBool isProductLoading = false.obs;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  Future<List<Product>> loadproduct({List<String> productId}) async {
    isProductLoading.toggle();
    List<Product> myproduct = [];
    Either<String, List<Product>> newproduct =
        await productRepo.fetchProduct(productId);

    newproduct.fold((l) {
      CustomeSnackbar(
        title: 'Error on Banner',
        message: l.toString(),
        icon: Icon(Icons.warning),
      );
    }, (r) {
      isProductLoading.toggle();
      myproduct = r.toList().obs;
      // print('I store data');
    });
    isProductLoading.toggle();
    return myproduct;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
