import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Product/product_horizental.dart';

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
              ? ListView.separated(
                  itemBuilder: (context, index) {
                    return ProductHorizental(
                      product: controller.cartList[index].product,
                      cartId:controller.cartList[index].cartId,
                      index: index,
                    );
                  },
                  separatorBuilder: (context, index) => Divider(),
                  itemCount: controller.cartList.length)
              : Center(child: Text('Nothing to Show.')),
        ),
      ),
    );
  }
}
