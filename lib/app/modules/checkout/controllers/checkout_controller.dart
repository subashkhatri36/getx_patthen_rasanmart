import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/enum/enum_convert.dart';
import 'package:rasan_mart/app/data/checkout/checkout_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:rasan_mart/app/modules/checkout/providers/checkout_provider.dart';
import 'package:rasan_mart/app/modules/conformdelivery/views/conformdelivery_view.dart';

class CheckoutController extends GetxController {
  final count = 0.obs;
  RxBool paymentMode = false.obs;
  RxBool addressSelected = false.obs;
  RxInt paymentSelectedMode = 0.obs;
  List<String> paymentModeImage = [
    'assets/images/cod.jpeg',
    'assets/images/khalti.png',
    'assets/images/imepay.jpg',
    'assets/images/esewa.png',
    'assets/images/paypal.png',
    'assets/images/visamaster.png'
  ];

  final auth = Get.find<MainauthController>().firebaseAuth;
  final cartController = Get.find<CartController>();

  CheckoutProvider checkoutProvider = CheckoutRepository();
  final deliveryController = Get.find<DeliveryController>();

  @override
  void onInit() {
    super.onInit();
  }

  void checkoutAuthenticationCheck() async {
    if (auth.currentUser != null) {
      //userLogged In and process to delivery cart.
      //delivery charge
      List<DeliveryTotalModel> deliveryTotalModel = [];
      var id = auth.currentUser?.uid ?? '';
      if (id.isNotEmpty && id != null) {
        ProductPriceCalculation productPriceCalculation =
            cartController.calculateTotalsAmount();
        String paymentType = 'Cash On Delivery';
        String paymentStaus = 'Not paid';
        EnumConvertor enumConvertor = EnumConvertor();

        paymentType = enumConvertor.paymentString(
            enumConvertor.paymentMode(paymentSelectedMode.value));
        if (paymentSelectedMode.value > 0) {
          //check of the payment method

        } else {
          Either<String, DeliveryTotalModel> savetodeliver =
              await checkoutProvider.saveToDelivery(id, cartController.cartList,
                  productPriceCalculation, paymentType, paymentStaus);
          savetodeliver.fold(
            (l) => print(l),
            (r) {
              deliveryTotalModel.add(r);
              deliveryController.deliveryModel = deliveryTotalModel.obs;
              cartController.cartList.clear();
              Get.to(() => ConformdeliveryView());
              print('Saved Successfully');
            },
          );
        }
      }
    } else {
      //show dialog to continue with offline or sign in.
      Get.dialog(Container(child: Text('Nothing to show')),
          barrierDismissible: true);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
