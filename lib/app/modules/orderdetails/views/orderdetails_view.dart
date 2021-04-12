import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/checkout/views/checkout_view.dart';

import '../controllers/orderdetails_controller.dart';

class OrderdetailsView extends GetView<OrderdetailsController> {
  final orders = Get.arguments;
  //DeliveryTotalModel model;
  @override
  Widget build(BuildContext context) {
    final deliveryController = Get.find<DeliveryController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text('Order details'),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: Defaults.defaultfontsize / 6),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Defaults.defaultPadding / 4,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).backgroundColor, width: 1)),
              child: SingleChildScrollView(
                child: Column(children: [
                  Container(
                      //width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(Defaults.defaultfontsize / 2),
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Billing and Payments',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      )),
                  BillingSection(
                    ischeckout: false,
                    model: orders,
                  ),
                  Container(
                    height: 40,
                    margin: EdgeInsets.symmetric(
                        vertical: Defaults.defaultfontsize),
                    padding: EdgeInsets.all(Defaults.defaultPadding / 6),
                    child: Text(
                      'Payment Mode' + ' ' + orders.paymentMode,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Card(
                      margin: EdgeInsets.all(Defaults.defaultPadding / 4),
                      child: Padding(
                        padding:
                            const EdgeInsets.all(Defaults.defaultPadding / 3),
                        child: Text(
                            'Delivery Address :\n' + orders.deliveryaddress),
                      )),
                  SizedBox(height: Defaults.defaultPadding),
                ]),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: Defaults.defaultPadding / 4,
              ),
              padding: EdgeInsets.symmetric(
                vertical: Defaults.defaultPadding / 3,
              ),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Theme.of(context).backgroundColor, width: 1)),
              child: Column(
                children: [
                  Container(
                      padding: EdgeInsets.all(Defaults.defaultfontsize / 2),
                      color: Theme.of(context).backgroundColor,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order Status',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      )),
                  Row(
                    children: [
                      Expanded(
                        child: Column(children: [
                          OrderProgressIndicator(
                            orders: orders,
                            stage: 1,
                            title: 'Delivery',
                            date: orders.deliveryDate,
                          ),
                          OrderProgressIndicator(
                            orders: orders,
                            stage: 0,
                            title: 'Shipping',
                            date: orders.shippingDate,
                          ),
                          // OrderProgressIndicator(orders: orders),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: Defaults.defaultfontsize / 3),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  size: Defaults.defaultPadding,
                                  color: Theme.of(context).backgroundColor,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: Defaults.defaultfontsize / 2),
                                  child: RichText(
                                    text: TextSpan(
                                      text: 'Ordered' + '\n',
                                      children: [
                                        TextSpan(
                                          text: orders.orderData,
                                          style: TextStyle(
                                              fontSize:
                                                  Defaults.defaultfontsize - 6,
                                              color: Colors.black87),
                                        )
                                      ],
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              Defaults.defaultfontsize - 3,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      ),
                      Expanded(child: Image.asset('assets/images/routes.png'))
                    ],
                  )
                ],
              ),
            ),
            if (orders.orderStatus.toUpperCase() == 'Ordered'.toUpperCase())
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.symmetric(
                    horizontal: Defaults.defaultPadding / 4),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomeTextButton(
                        label: 'Cancel Order',
                        color: Theme.of(context).backgroundColor,
                        onPressed: () {
                          showDialog(
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Deletion Warning'),
                                  content: Text(
                                      'Are You Sure to Cancel this Order?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Text('Close'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deliveryController.deleteDeliveryItems(
                                            orders.id, orders);
                                        Get.back();
                                        Get.back();
                                      },
                                      child: Text('Cancel Order'),
                                    ),
                                  ],
                                );
                              },
                              context: context);
                        },
                      ),
                    ),
                  ],
                ),
              )
            else
              SizedBox(height: Defaults.defaultPadding),
          ],
        ),
      ),
    );
  }
}

class OrderProgressIndicator extends StatelessWidget {
  const OrderProgressIndicator({
    Key key,
    @required this.orders,
    this.title,
    this.date,
    this.stage,
  }) : super(key: key);

  final orders;
  final String title;
  final String date;
  final int stage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 70,
          width: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: Defaults.defaultPadding,
                color: getColors(
                    stage, orders.orderStatus, context, orders.orderStatus),
              ),
              Expanded(
                child: RotatedBox(
                  quarterTurns: -1,
                  child: LinearProgressIndicator(
                    value: stage == 0
                        ? orders.orderStatus.toUpperCase() ==
                                'shipping'.toUpperCase()
                            ? 100
                            : 0.0
                        : orders.orderStatus.toUpperCase() ==
                                    'completed'.toUpperCase() ||
                                orders.orderStatus.toUpperCase() ==
                                    'shipping'.toUpperCase()
                            ? 100
                            : 0.0,
                    valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).backgroundColor),
                    backgroundColor: Colors.grey[300],
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: RichText(
          text: TextSpan(
            text: title + '\n',
            children: [
              TextSpan(
                text: date.isEmpty ? 'No Date' : date,
                style: TextStyle(
                    fontSize: Defaults.defaultfontsize - 6,
                    color: Colors.black87),
              )
            ],
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Defaults.defaultfontsize - 3,
                color: Colors.black),
          ),
        ))
      ],
    );
  }

  Color getColors(
      int stage, String status, BuildContext context, String shipping) {
    if (stage == 0) {
      //shipping
      if (status.toUpperCase() == 'shipping'.toUpperCase())
        return Theme.of(context).backgroundColor;
      else
        return Colors.grey[300];
    } else {
      //delivery
      if (status.toUpperCase() == 'completed'.toUpperCase() &&
          status.toUpperCase() == 'shipping'.toUpperCase())
        return Theme.of(context).backgroundColor;
      else
        return Colors.grey[300];
    }
  }
}
