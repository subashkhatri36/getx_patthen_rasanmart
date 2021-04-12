import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';
import 'package:rasan_mart/app/modules/addAddress/views/add_address_view.dart';
import 'package:rasan_mart/app/modules/addAddress/views/address_selected_navigation.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/setting_controller.dart';

import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:rasan_mart/app/modules/checkout/views/totalcalculationsummary_view.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  final cartController = Get.find<CartController>();
  final addressController = Get.find<AddAddressController>();
  final checkoutController = Get.put(CheckoutController());
  final settings = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => checkoutController.showdialog.value
        ? Scaffold(
            body: Container(
              width: MediaQuery.of(context).size.width,
              color: Theme.of(context).backgroundColor,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Ordering your Product.\nPlease Don\'t close.',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(height: Defaults.defaultPadding),
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                  ]),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).backgroundColor,
              title: Text('Checkout'),
            ),
            body: SingleChildScrollView(
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
                            color: Theme.of(context).backgroundColor,
                            width: 1)),
                    child: SingleChildScrollView(
                      child: Column(children: [
                        Container(
                            //width: MediaQuery.of(context).size.width,
                            padding:
                                EdgeInsets.all(Defaults.defaultfontsize / 2),
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
                        BillingSection(),
                        Obx(() => settings.showCoupen.value
                            ? Container(
                                margin: EdgeInsets.all(
                                    Defaults.defaultfontsize / 2),
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Theme.of(context).backgroundColor,
                                        Colors.orange[700]
                                      ],
                                      stops: [0.0, 0.9],
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            Defaults.defaultfontsize / 3)),
                                    border: Border.all(color: Colors.black26)),
                                padding: EdgeInsets.symmetric(
                                    vertical: Defaults.defaultfontsize / 2,
                                    horizontal: Defaults.defaultfontsize),
                                child: Row(children: [
                                  Expanded(
                                    flex: 7,
                                    child: Text(
                                        'Use your coupen to get ${settings.coupen.coupenType} (${settings.coupen.coupenAmount})',
                                        style: TextStyle(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        )),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: TextButton(
                                        style: TextButton.styleFrom(
                                            primary:
                                                Theme.of(context).primaryColor,
                                            backgroundColor: Theme.of(context)
                                                .backgroundColor),
                                        onPressed: () {
                                          if (!settings.coupenContiainer.value)
                                            settings.coupenContiainer.value =
                                                true;
                                          else
                                            settings.coupenContiainer.value =
                                                false;
                                        },
                                        child: Text('Use')),
                                  )
                                ]),
                              )
                            : Container()),
                        Container(
                          height: 30,
                          margin: EdgeInsets.symmetric(
                              vertical: Defaults.defaultfontsize),
                          padding: EdgeInsets.all(Defaults.defaultPadding / 6),
                          child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Payment Mode',
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: checkoutController
                                          .paymentModeImage.length,
                                      itemBuilder: (context, index) {
                                        return Obx(
                                          () => InkWell(
                                            onTap: () {
                                              checkoutController
                                                  .paymentSelectedMode
                                                  .value = index;
                                            },
                                            child: Container(
                                              height: 30,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                color: checkoutController
                                                            .paymentSelectedMode
                                                            .value ==
                                                        index
                                                    ? Theme.of(context)
                                                        .backgroundColor
                                                    : Theme.of(context)
                                                        .primaryColor,
                                              )),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Defaults.defaultfontsize /
                                                          2),
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      Defaults.defaultfontsize /
                                                          2),
                                              child: Image.asset(
                                                checkoutController
                                                    .paymentModeImage[index],
                                                height: 50,
                                                width: 50,
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                )
                              ]),
                        ),
                        Obx(() => Column(children: [
                              if (addressController.newAddress.length < 1)
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => AddAddressView(),
                                        arguments: [true, false]);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(
                                          Defaults.defaultPadding - 5),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color:
                                                  Themes.lightcounterbtnColor)),
                                      child: Row(
                                        children: [
                                          Icon(Icons.add),
                                          SizedBox(
                                              width:
                                                  Defaults.defaultPadding / 2),
                                          Text('Add Address')
                                        ],
                                      )),
                                ),
                              Card(
                                child: addressController.isAddressUpdated.value
                                    ? AddressSelectedWidget(
                                        controller: addressController,
                                        ischange: true,
                                        isadd: false)
                                    : AddressSelectedWidget(
                                        controller: addressController,
                                        ischange: true,
                                        isadd: false),
                              ),
                            ])),
                        SizedBox(height: Defaults.defaultPadding / 3),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: Defaults.defaultPadding / 2),
                          child: Text(
                            'Note*\nOnce you buy our product and the order product is shipping then you wont able to cancel the order. ${Strings.appName} always at your service.',
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                                color: Theme.of(context).backgroundColor,
                                fontStyle: FontStyle.italic),
                          ),
                        ),
                        SizedBox(height: Defaults.defaultPadding),
                      ]),
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(
                        horizontal: Defaults.defaultPadding / 4),
                    child: Row(
                      children: [
                        Expanded(
                          child: CustomeTextButton(
                            label: 'Buy',
                            color: Theme.of(context).backgroundColor,
                            onPressed: () {
                              if (FirebaseAuth.instance.currentUser != null)
                                controller.checkoutAuthenticationCheck();
                              else
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Row(
                                          children: [
                                            Icon(Icons.warning),
                                            Text("Warning !"),
                                          ],
                                        ),
                                        content: Text(
                                            "Are you sure to delete Cart Itme"),
                                        actions: [
                                          CustomeTextButton(
                                            label: 'Cancel',
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          CustomeTextButton(
                                            label: 'Sign In',
                                            color: Themes.lightBackgroundColor,
                                            onPressed: () async {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
  }
}

class BillingSection extends StatelessWidget {
  const BillingSection({
    Key key,
    this.ischeckout = true,
    this.model,
  }) : super(key: key);
  final bool ischeckout;
  final DeliveryTotalModel model;

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();
    final settings = Get.find<SettingController>();
    final checkoutController = Get.find<CheckoutController>();
  

    int i = 1;
    return Column(
      children: [
        SizedBox(height: Defaults.defaultfontsize / 4),
        ItemsofCart(
          subheader: false,
        ),
        if (ischeckout)
          for (CartModel cmodel in cartController.cartList)
            ItemsofCart(
              subheader: true,
              serial: i++,
              product: cmodel.product.productName,
              qty: cmodel.product.qty,
              rate: cmodel.product.productPrice,
              total: cmodel.product.price,
            )
        else
          for (DeliveryModel model in model.deliverymodel)
            ItemsofCart(
              subheader: true,
              serial: i++,
              product: model.productName,
              qty: model.qty,
              rate: model.rate,
              total: model.price,
            ),
        if (ischeckout)
          Obx(() => settings.coupenContiainer.value
              ? TotalcalculationsummaryView(
                  ischeckout: ischeckout,
                  checkoutController: checkoutController)
              : TotalcalculationsummaryView(
                  ischeckout: ischeckout,
                  checkoutController: checkoutController))
        else
          TotalcalculationsummaryView(
            ischeckout: ischeckout,
            model: model,
          ),
      ],
    );
  }
}

class ItemsofCart extends StatelessWidget {
  const ItemsofCart({
    Key key,
    this.subheader = true,
    this.serial,
    this.product,
    this.qty,
    this.rate,
    this.total,
  }) : super(key: key);
  final bool subheader;
  final int serial;
  final String product;
  final int qty;
  final double rate;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 1,
                child: Text(
                  subheader ? serial.toString() : 'S.n',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight:
                          subheader ? FontWeight.normal : FontWeight.bold),
                )),
            Expanded(
                flex: 4,
                child: Text(
                  subheader ? product.toString() : 'Item Name',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontWeight:
                          subheader ? FontWeight.normal : FontWeight.bold),
                )),
            Expanded(
                flex: 1,
                child: Text(
                  subheader ? qty.toString() : 'Qty',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight:
                          subheader ? FontWeight.normal : FontWeight.bold),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  subheader ? rate.toString() + '/-' : 'Rate',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight:
                          subheader ? FontWeight.normal : FontWeight.bold),
                )),
            Expanded(
                flex: 3,
                child: Text(
                  subheader ? total.toString() + '/-' : 'Total',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight:
                          subheader ? FontWeight.normal : FontWeight.bold),
                )),
          ],
        ),
        Divider(
          color: Colors.black26,
        )
      ],
    );
  }
}
