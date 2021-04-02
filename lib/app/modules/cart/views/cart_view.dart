import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Product/product_horizental.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/checkout/views/checkout_view.dart';

import '../controllers/cart_controller.dart';

class CartView extends GetView<CartController> {
  //final cartController = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    //int val = controller.cartList?.length ?? 0;
    //controller.c

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Shopping Cart'),
      ),
      body: Center(
        child: Obx(
          () => controller.cartList.length > 0
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(Defaults.defaultfontsize),
                        child: Text(
                            'Total (${controller.cartList?.length ?? 0}) Item(s)')),
                    Divider(),
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            return ProductHorizental(
                              product: controller.cartList[index].product,
                              cartId: controller.cartList[index].cartId,
                              index: index,
                              horizental: true,
                            );
                          },
                          shrinkWrap: true,
                          separatorBuilder: (context, index) => Divider(
                                thickness: 1,
                              ),
                          itemCount: controller.cartList.length),
                    ),
                    Column(
                      children: [
                        Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                                flex: 6,
                                child: Container(
                                    margin: EdgeInsets.all(
                                        Defaults.defaultfontsize / 2),
                                    child: Obx(
                                      () => Text(
                                        'Total NRs. ' +
                                            controller
                                                .calculateTotalsAmount()
                                                .grandTotal
                                                .toStringAsFixed(2)
                                                .toString() +
                                            "/-",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: Defaults.defaultfontsize,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ))),
                            Expanded(
                              flex: 4,
                              child: CustomeTextButton(
                                label: 'Continue',
                                color: Theme.of(context).backgroundColor,
                                onPressed: () {
                                  Get.to(() => CheckoutView());
                                },
                              ),
                            ),
                            SizedBox(width: 2),
                          ],
                        )
                      ],
                    )
                  ],
                )
              : Center(child: Text('Nothing to Show.')),
        ),
      ),
    );
  }
}
