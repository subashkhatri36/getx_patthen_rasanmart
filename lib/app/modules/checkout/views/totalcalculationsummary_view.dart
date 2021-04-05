import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';

class TotalcalculationsummaryView extends GetView {
  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    ProductPriceCalculation calculation =
        cartController.calculateTotalsAmount();
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
                    value: calculation.totalItems,
                    i: 0,
                  ),
                  CalculationWidgetItems(
                    type: 'Total Price',
                    value: calculation.totalprice,
                  ),
                  CalculationWidgetItems(
                    type: 'Delivery Charge',
                    value: calculation.deliverycharge,
                  ),
                  CalculationWidgetItems(
                    type: 'Discount (' +
                        calculation.totaldiscount.toString() +
                        ')',
                    value: calculation.totaldiscountprice,
                  ),
                  CalculationWidgetItems(
                    type: 'Coupen',
                    value: calculation.coupen,
                  ),
                  CalculationWidgetItems(
                    type: 'Grand Total',
                    value: calculation.grandTotal,
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
