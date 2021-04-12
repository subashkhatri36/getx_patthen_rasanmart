import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/core/enum/enum_convert.dart';
import 'package:rasan_mart/app/data/checkout/checkout_repository.dart';

import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';

import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/setting_controller.dart';

import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:rasan_mart/app/modules/checkout/providers/checkout_provider.dart';

import 'package:rasan_mart/app/modules/conformdelivery/views/conformdelivery_view.dart';
import 'package:rasan_mart/app/modules/home/views/notification_model.dart';
import 'package:rasan_mart/app/modules/notificationpage/controllers/notification_controller.dart';

class CheckoutController extends GetxController {
  

  RxBool paymentMode = false.obs;
  RxBool addressSelected = false.obs;
  RxInt paymentSelectedMode = 0.obs;
  RxBool minDelivery = false.obs;
  RxDouble minDeliveryAmount = 0.0.obs;
  List<String> paymentModeImage = [
    'assets/images/cod.jpeg',
    // 'assets/images/khalti.png',
    // 'assets/images/imepay.jpg',
    // 'assets/images/esewa.png',
    // 'assets/images/paypal.png',
    // 'assets/images/visamaster.png'
  ];

  final auth = FirebaseAuth.instance;
  final cartController = Get.find<CartController>();
  final addressControllr = Get.find<AddAddressController>();

  CheckoutProvider checkoutProvider = CheckoutRepository();
  final deliveryController = Get.put(DeliveryController());
  RxBool showdialog = false.obs;
  final settings = Get.find<SettingController>();
  ProductPriceCalculation productPriceCalculation;

  final notificationController = Get.find<NotificationController>();

  @override
  void onInit() {
    super.onInit();
  }

  void checkoutAuthenticationCheck() async {
    showdialog.value = true;
    if (auth.currentUser != null) {
      if (minDelivery.value) {
        var id = auth.currentUser?.uid ?? '';
        // productPriceCalculation = totalsAmount();
        if (id.isNotEmpty && id != null && productPriceCalculation != null) {
          String paymentType = 'Cash On Delivery';
          String paymentStaus = 'Not paid';
          EnumConvertor enumConvertor = EnumConvertor();

          paymentType = enumConvertor.paymentString(
              enumConvertor.paymentMode(paymentSelectedMode.value));
          if (paymentSelectedMode.value > 0) {
            //check of the payment method

          } else {
            String address = addressControllr.selectedAddressString.value;
            if (address.isNotEmpty) {
              Either<String, DeliveryTotalModel> savetodeliver =
                  await checkoutProvider.saveToDelivery(
                id,
                cartController.cartList,
                productPriceCalculation,
                paymentType,
                paymentStaus,
                address,
                settings.showCoupen.value,
                settings.coupen.totalpurchase,
                settings.coupen.coupenAmount,
              );
              savetodeliver.fold(
                (l) => print(l),
                (r) {
                  List<DeliveryTotalModel> model = [];
                  model.add(r);
                  if (deliveryController.deliveryModel == null)
                    deliveryController.deliveryModel = model.obs;
                  else
                    deliveryController.deliveryModel.add(r);

                  cartController.cartList.clear();
                  DateTime now = DateTime.now();
                  DateFormat formatter = DateFormat('yyyy-MM-dd');
                  NotificationData notice = NotificationData(
                    noticeRead: false,
                    noticedate: formatter.format(now),
                    title: 'Order Delivery',
                    message:
                        'Thank you for choosing us. Your Orders items will be delivered with in 48 hours.\n Thank you.',
                    imgpath:
                        'https://firebasestorage.googleapis.com/v0/b/rasan-ae826.appspot.com/o/setting%2Fshoppingicon.png?alt=media&token=060741de-746a-455e-b70c-55c9f29dc9f7',
                  );

                  notificationController.addNotification(notice);


                  Get.to(() => ConformdeliveryView());
                  print('Saved Successfully');
                },
              );
            } else
              CustomeSnackbar(
                  title: 'Warning',
                  message: 'You must add address before proceeding. Thank you.',
                  icon: Icon(Icons.warning));
          }
        }
      } else {
        CustomeSnackbar(
            title: 'Information',
            message:
                'You must Order minimus (${minDeliveryAmount.value}) to delivery order in your place. Thank you.',
            icon: Icon(Icons.info));
      }
    }
    showdialog.value = false;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  ProductPriceCalculation totalsAmount(
      {SettingController setting,
      AddAddressController addressController,
      CartController cartController}) {
    int totalItems = cartController.cartList.length;
    int totaldiscount = 0;
    double totalprice = 0;
    double totaldiscountprice = 0;
    double deliveryCharge = 0.0;
    double coupenCharge = 0.0;
    double grandTotal = 0.0;

    //working on coupen

    cartController.cartList.forEach((element) {
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
    if (FirebaseAuth.instance.currentUser != null) {
      if (setting.userCoupen.totalpurchase > setting.coupen.totalpurchase &&
          setting.userCoupen.totalpurchaseCash > setting.coupen.coupenlimit) {
        setting.showCoupen.value = true;

        if (setting.coupenContiainer.value) {
          if (setting.coupen.coupenType.toUpperCase() == 'flat'.toUpperCase()) {
            coupenCharge = setting.coupen.coupenAmount;
          } else {
            coupenCharge = totalprice * setting.coupen.coupenAmount;
          }
        } else {
          coupenCharge = 0.0;
          setting.showCoupen.value = true;
        }
      }
    }

    bool freeaddress = false;
    String address = '';
    setting.deliveryPrice.freeDeliveryCity.forEach((element) {
      if (addressController.newAddress != null)
        addressController.newAddress.forEach((value) {
          if (value.city.toUpperCase() == element.toUpperCase()) {
            address = element;
            freeaddress = true;
          }
        });
    });

    if (address.isNotEmpty) {
      if (!freeaddress) {
        if (setting.deliveryPrice.aboveDeliveryFree < totalprice)
          deliveryCharge = 0.0;
        else {
          if (setting.deliveryPrice.deliveryType.toUpperCase() ==
              'flat'.toUpperCase()) {
            print(setting.deliveryPrice.deliveryType);
            deliveryCharge = setting.deliveryPrice.deliveryAmount;
          } else {
            deliveryCharge = totalprice * setting.deliveryPrice.deliveryAmount;
          }
        }
      }
    } else {
      if (setting.deliveryPrice.deliveryType.toUpperCase() ==
          'flat'.toUpperCase()) {
        deliveryCharge = setting.deliveryPrice.deliveryAmount;
      } else {
        deliveryCharge = totalprice * setting.deliveryPrice.deliveryAmount;
      }
    }

    grandTotal = totalprice - totaldiscountprice;
    grandTotal = grandTotal - coupenCharge;
    grandTotal += deliveryCharge;
    if (grandTotal >= setting.deliveryPrice.maxDelivery)
      minDelivery.value = true;
    else
      minDelivery.value = false;

    minDeliveryAmount.value = setting.deliveryPrice.maxDelivery;

    return ProductPriceCalculation(
        totalprice: totalprice.toPrecision(2),
        totalItems: totalItems,
        totaldiscount: totaldiscount,
        totaldiscountprice: totaldiscountprice,
        grandTotal: grandTotal,
        deliverycharge: deliveryCharge,
        coupen: coupenCharge);
  }
}
