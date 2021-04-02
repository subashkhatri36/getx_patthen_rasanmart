import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/data/cart/cart_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_offline.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartController extends GetxController {
  RxList<CartModel> cartList;
  RxBool isLoadingCart = false.obs;
  CartProvider cartRepo = CartRepository();
  RxDouble grandTotal = 0.0.obs;

  final firebase = Get.find<MainauthController>();
  RxInt cartTotal = 0.obs;
  RxInt cindex = 0.obs;
  CartOffline offlineCart = new CartOffline();
  RxBool cartUpdate = false.obs;

  @override
  void onInit() async {
    var id = firebase.firebaseAuth.currentUser?.uid ?? '';
    await loadCart(id);
    super.onInit();
  }

  Future<void> loadCart(String data) async {
    List<CartModel> newcartList = [];
    if (data != null && data.isNotEmpty) {
      Either<String, List<CartModel>> cart = await cartRepo.fetchCart(data);
      cart.fold((l) {
        CustomeSnackbar(
            title: 'Error Loading Cart',
            message: l.toString(),
            icon: Icon(Icons.warning));
        print(l);
        cartList = newcartList.obs;
        cartTotal = cartList.length.obs;
      }, (r) {
        newcartList = r.toList();
        cartList = newcartList.obs;
        cartTotal = cartList.length.obs;
      });
    } else {
      //not logged in
      Either<String, List<CartModel>> cart =
          await offlineCart.loadCartOffline();
      cart.fold((l) {
        // CustomeSnackbar(
        //     title: 'Error Loading Cart',
        //     message: l.toString(),
        //     icon: Icon(Icons.warning));
        //  newcartList = r.toList();
        cartList = newcartList.obs;
        cartTotal = cartList.length.obs;
        print(l);
      }, (r) {
        newcartList = r.toList();
        cartList = newcartList.obs;
        cartTotal = cartList.length.obs;
      });

      // cartList = newcartList.obs;
      // cartTotal = cartList.length.obs;
    }
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

        cartList.removeAt(index);
        cartTotal.value -= 1;
        cindex.value = 0;
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
    if (firebase.firebaseAuth.currentUser != null) {
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
    } else {
      //not logged in data
      CartModel cartModel = new CartModel(product: product, cartId: '');
      loaddataOffline(cartModel);
    }
  }

  void loaddataOffline(CartModel cartModel) async {
    Either<String, String> cart = await offlineCart.addCartOffline(cartModel);
    cart.fold((l) {
      CustomeSnackbar(
          title: 'Error Loading Cart',
          message: l.toString(),
          icon: Icon(Icons.warning));
      print(l);
    }, (r) {
      cartList.add(cartModel);
      cartTotal = cartList.length.obs;
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  double calculateTotalPrice() {
    double total = 1.0;
    // double total
    if (cartList.length > 0) {}

    return total;
  }

  ProductPriceCalculation calculateTotalsAmount() {
    int totalItems = cartList.length;
    int totaldiscount = 0;
    double totalprice = 0;
    double totaldiscountprice = 0;
    // double grandTotalAmount = 0;

    cartList.forEach((element) {
      if (element.product.productOnDiscount) {
        if (element.product.productDiscountType.toUpperCase() ==
            'Flat'.toUpperCase()) {
          totaldiscountprice += element.product.productDiscount;
        } else {
          double disountpercentage =
              element.product.price * (element.product.productDiscount / 100);

          totaldiscountprice += disountpercentage;
        }

        totaldiscount++;
      }

      totalprice += element.product.price;
    });
    grandTotal.value = totalprice - totaldiscountprice;

    return ProductPriceCalculation(
        totalprice: totalprice.toPrecision(2),
        totalItems: totalItems,
        totaldiscount: totaldiscount,
        totaldiscountprice: totaldiscountprice,
        grandTotal: grandTotal.value);
  }
}
