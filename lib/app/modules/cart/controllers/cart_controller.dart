import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/data/cart/cart_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList;
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
    List<CartModel> newcartList = [];
    Either<String, List<CartModel>> cart = await cartRepo.fetchCart(data);
    cart.fold(
        (l) => CustomeSnackbar(
              title: 'Error Loading Cart',
              message: l.toString(),
              icon: Icon(Icons.warning),
            ), (r) {
      newcartList = r.toList();
      cartList = newcartList.obs;
      cartTotal = cartList.length.obs;
    });
  }

  removeCart({@required int index, @required String productId}) async {
    Either<String, String> cart =
        await cartRepo.deleteCartItems(cartId: productId);
    cart.fold(
        (l) => CustomeSnackbar(
              title: 'Error on removing Cart',
              message: l.toString(),
              icon: Icon(Icons.warning),
            ), (r) {
      if (r.isNotEmpty) {
        CustomeSnackbar(
          title: 'Successful',
          message: Strings.successMessage,
          icon: Icon(Icons.arrow_right),
        );
        cartList.removeAt(index).obs;
        cartTotal.value -= 1;
      } else {
        CustomeSnackbar(
          title: 'Failed',
          message: Strings.FailedMessage,
          icon: Icon(Icons.done),
        );
      }
    });
  }

  addCart({@required Product product}) async {
    Either<String, String> cart;
    bool checkdata = false;
    CartModel cartModel;
    int qty = product.qty;
    double pprice = product.price;

    cartList.forEach((value) {
      if (value.product.productId == product.productId) {
        Product product = value.product;
        product.setQty(qty);
        product.setPrice(pprice);
        cartModel = new CartModel(product: product, cartId: value.cartId);
        checkdata = true;
      }
    });

    if (checkdata) {
      cart = await cartRepo.updateCart(cartModel: cartModel);
      //if there is already a data then update it
    } else {
      cart = await cartRepo.addCart(
        product: product,
      );
    }

    //else add to
    cart.fold(
        (l) => CustomeSnackbar(
              title: 'Error on adding to Cart',
              message: l.toString(),
              icon: Icon(Icons.warning),
            ), (r) {
      CustomeSnackbar(
        title: 'Successful',
        message: Strings.successMessage,
        icon: Icon(Icons.arrow_right),
      );
      if (!checkdata) if (r.length > 0) {
        cartTotal.value += 1;
        cartList.add(CartModel(product: product, cartId: r));
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
