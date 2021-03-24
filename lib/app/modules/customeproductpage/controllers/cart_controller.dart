import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/cart/cart_repository.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartController extends GetxController {
  RxList<Product> cartList;
  RxBool isLoadingCart = false.obs;
  CartProvider cartRepo = CartRepository();

  @override
  void onInit() {
    super.onInit();
  }

  loadCart() async {
    List<Product> newcartList = [];
    Either<String, List<Product>> cart = await cartRepo.fetchCart();
    cart.fold(
        (l) => CustomeSnackbar(
            title: 'Error Loading Cart',
            message: l.toString(),
            icon: Icon(Icons.warning),
            backgroundColor: Colors.white), (r) {
      newcartList = r.toList();
      cartList = newcartList.obs;
    });
  }

  removeCart({
    @required int index,
    @required String productId,
  }) async {
    Either<String, String> cart =
        await cartRepo.removeCart(productId: productId);
    cart.fold(
        (l) => CustomeSnackbar(
              title: 'Error on removing Cart',
              message: l.toString(),
              backgroundColor: Colors.white,
              icon: Icon(Icons.warning),
            ), (r) {
      CustomeSnackbar(
        title: 'Successful',
        message: r.toString(),
        icon: Icon(Icons.arrow_right),
      );
      loadCart();
      // cartList.removeAt(index);
    });
  }

  addCart({
    @required product,
  }) async {
    Either<String, String> cart = await cartRepo.addCart(
      product: product,
    );
    cart.fold(
        (l) => CustomeSnackbar(
            title: 'Error on removing Cart',
            message: l.toString(),
            icon: Icon(Icons.warning),
            backgroundColor: Colors.white), (r) {
      CustomeSnackbar(
        title: 'Successful',
        message: r.toString(),
        icon: Icon(Icons.arrow_right),
      );

      loadCart();
      // addToCart(product);
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void addToCart(Product product) => cartList.add(product);
}
