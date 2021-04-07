import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/account/views/order_view.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';

import '../controllers/deliveryviewall_controller.dart';

class DeliveryviewallView extends GetView<DeliveryviewallController> {
  final deliveryController = Get.find<DeliveryController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('Orders'),
        ),
        body: Obx(() => GridView.count(
              childAspectRatio: .8,
              //physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisSpacing: 2,
              mainAxisSpacing: 3,
              crossAxisCount: 2,
              children: List.generate(deliveryController.deliveryModel.length,
                  (index) {
                DeliveryTotalModel model =
                    deliveryController.deliveryModel[index];
                return OrderContiainer(model);
              }),
            )));
  }
}
