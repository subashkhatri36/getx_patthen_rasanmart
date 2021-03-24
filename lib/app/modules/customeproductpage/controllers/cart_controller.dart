import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/cart/cart_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartController extends GetxController {
  RxList<Product> cartList;
  RxBool isLoadingCart = false.obs;
  CartProvider cartRepo = CartRepository();

  final firebase = Get.find<MainauthController>();
  RxInt cartTotal = 0.obs;

  @override
  void onInit() async {
    await loadCart(firebase.firebaseAuth.currentUser.uid);
    super.onInit();
  }

  Future<void> loadCart(String data) async {
    List<Product> newcartList = [];
    Either<String, List<Product>> cart = await cartRepo.fetchCart(data);
    cart.fold(
        (l) => CustomeSnackbar(
            title: 'Error Loading Cart',
            message: l.toString(),
            icon: Icon(Icons.warning),
            backgroundColor: Colors.white), (r) {
      newcartList = r.toList();
      cartList = newcartList.obs;
      cartTotal = cartList.length.obs;
    });
  }

  removeCart({@required int index, @required String productId}) async {
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
      loadCart(null);
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
            title: 'Error on adding to Cart',
            message: l.toString(),
            icon: Icon(Icons.warning),
            backgroundColor: Colors.white), (r) {
      CustomeSnackbar(
        title: 'Successful',
        message: r.toString(),
        icon: Icon(Icons.arrow_right),
      );
      cartTotal.value += 1;
      cartList.add(product);

      //   loadCart(null);
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
