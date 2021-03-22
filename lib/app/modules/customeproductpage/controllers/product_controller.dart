import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/Product/product_repositories.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/product_provider.dart';

class ProductController extends GetxController {
  RxList<RxList<Product>> productlist;
  ProductRepo productRepo = new ProductRepositories();
  RxBool isProductLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  loadproduct({List<String> productId}) async {
    List<List<Product>> newproductList = productlist;
    isProductLoading.toggle();
    Either<String, List<Product>> newproduct =
        await productRepo.fetchProduct(productId);

    newproduct.fold(
        (l) => CustomeSnackbar(
              title: 'Error on Banner',
              message: l.toString(),
              icon: Icon(Icons.warning),
            ), (r) {
      if (r != null) {
        newproductList.add(r.toList());
        productlist = newproductList.obs;
      }
    });
    isProductLoading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
