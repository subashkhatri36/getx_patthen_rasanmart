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
  final CheckoutController checkoutController;

  TotalcalculationsummaryView({
    this.ischeckout = true,
    this.model,
    this.checkoutController,
  });

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final setting = Get.find<SettingController>();
    final addressController = Get.find<AddAddressController>();
    ProductPriceCalculation calculation;
    if (ischeckout) {
      calculation = checkoutController.totalsAmount(
        setting: setting,
        addressController: addressController,
        cartController: cartController,
      );
      checkoutController.productPriceCalculation = calculation;
    }

    //usedcoupen

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
