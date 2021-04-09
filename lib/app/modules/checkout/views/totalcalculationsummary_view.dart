import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';

import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/checkout_controller.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/setting_controller.dart';

import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';

class TotalcalculationsummaryView extends StatelessWidget {
  final bool ischeckout;
  final DeliveryTotalModel model;

  TotalcalculationsummaryView({
    this.ischeckout = true,
    this.model,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final setting = Get.find<SettingController>();
    final addressController = Get.find<AddAddressController>();
    final checkout = Get.find<CheckoutController>();
    ProductPriceCalculation calculation =
        cartController.calculateTotalsAmount();
    double deliverycharge = 0.0;
    double coupen = 0;

    if (ischeckout) {
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
        if (freeaddress) {
          calculation.deliverycharge = 0.0;
        } else {
          //cost of delivery
          if (setting.deliveryPrice.aboveDeliveryFree < calculation.totalprice)
            calculation.deliverycharge = 0.0;
          else {
            if (setting.deliveryPrice.deliveryType.toUpperCase() ==
                'flat'.toUpperCase()) {
              calculation.deliverycharge = setting.deliveryPrice.deliveryAmount;
              calculation.grandTotal += calculation.deliverycharge;
            } else {
              calculation.deliverycharge =
                  calculation.totalprice * setting.deliveryPrice.deliveryAmount;
              calculation.grandTotal += calculation.deliverycharge;
            }
          }
        }
      }
      if (FirebaseAuth.instance.currentUser != null) if (setting
                  .userCoupen.totalpurchase >
              setting.coupen.totalpurchase &&
          setting.userCoupen.totalpurchaseCash > setting.coupen.coupenlimit) {
        setting.showCoupen.value = true;
        print('Here');
        if (setting.coupenContiainer.value) {
          if (setting.coupen.coupenType.toUpperCase() == 'flat'.toUpperCase()) {
            calculation.coupen = setting.coupen.coupenAmount;
            calculation.grandTotal -= calculation.coupen;
          } else {
            calculation.coupen =
                calculation.totalprice * setting.coupen.coupenAmount;
            calculation.grandTotal -= calculation.coupen;
          }
        }
      } else
        calculation.coupen = 0.0;
    }
    checkout.productPriceCalculation = calculation;
    print(calculation.deliverycharge);

    return Container(
      child: Row(
        children: [
          //assets/images/happy.png
          Image.asset(
            'assets/images/shopping.jpg',
            height: 100,
            width: 130,
            fit: BoxFit.cover,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 16.0,
                    color: Colors.lightBlue.shade900,
                  ),
                  left: BorderSide(
                    width: 1.0,
                    color: Themes.lightBackgroundColor,
                  ),
                ),
                color: Colors.white,
              ),
              child: Column(
                children: [
                  CalculationWidgetItems(
                    type: 'Total Item(s)',
                    value: ischeckout
                        ? calculation.totalItems
                        : model.deliverymodel.length.toString(),
                    i: 0,
                  ),
                  CalculationWidgetItems(
                    type: 'Total Price',
                    value:
                        ischeckout ? calculation.totalprice : model.totalprice,
                  ),
                  CalculationWidgetItems(
                    type: 'Delivery Charge',
                    value: ischeckout
                        ? calculation.deliverycharge
                        : model.deliveryCharge,
                  ),
                  CalculationWidgetItems(
                    type: ischeckout
                        ? 'Discount (' +
                            calculation.totaldiscount.toString() +
                            ')'
                        : 'Discount',
                    value: ischeckout
                        ? calculation.totaldiscountprice
                        : model.discount,
                  ),
                  CalculationWidgetItems(
                    type: 'Coupen',
                    value: ischeckout ? calculation.coupen : model.coupen,
                  ),
                  CalculationWidgetItems(
                    type: 'Grand Total',
                    value:
                        ischeckout ? calculation.grandTotal : model.grandtotal,
                    i: -1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculationWidgetItems extends StatelessWidget {
  const CalculationWidgetItems({
    Key key,
    this.type,
    this.value,
    this.i = 1,
  }) : super(key: key);

  final String type;
  final value;
  final int i;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: Text(
                  type,
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  i == 0 ? value.toString() : value.toString() + '/-',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
          ],
        ),
        if (i != -1)
          Divider(
            color: Colors.black26,
          )
        else
          SizedBox(height: 5)
      ],
    );
  }
}
