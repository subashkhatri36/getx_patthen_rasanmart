import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/amount_box.dart';
import 'package:rasan_mart/app/Widgets/Product/cart_and_quickview_btn.dart';
import 'package:rasan_mart/app/Widgets/Product/total_product_price.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/image_container.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productdetail/views/productdetail_view.dart';

class ProductHorizental extends StatefulWidget {
  final Product product;
  final int index;
  final String cartId;
  final bool horizental;
  final bool checkout;

  const ProductHorizental({
    Key key,
    @required this.product,
    @required this.index,
    @required this.cartId,
    this.horizental,
    this.checkout = false,
  }) : super(key: key);

  @override
  _ProductHorizentalState createState() => _ProductHorizentalState();
}

class _ProductHorizentalState extends State<ProductHorizental> {
  Product get _product => widget.product;
  String get _cartId => widget.cartId;
  bool get checkout => widget.checkout;
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
        horizontal: Defaults.defaultfontsize,
        vertical: Defaults.defaultPadding / 2,
      ),
      margin: EdgeInsets.symmetric(
          horizontal: checkout ? Defaults.defaultPadding / 3 : 0),
      decoration: checkout
          ? BoxDecoration(
              border: Border.all(color: Themes.lightcounterbtnColor))
          : BoxDecoration(border: Border.all(color: Colors.transparent)),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .23,
              margin: EdgeInsets.only(right: Defaults.defaultfontsize / 1.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageContainer(
                      path: _product.productImages[0].toString(),
                      context: context,
                      width: MediaQuery.of(context).size.width * .23,
                      height: 90),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (_product.productOnSale)
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Themes.lightSalesolor,
                          child: Text(
                            'Sale',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: Defaults.defaultfontsize - 5),
                          ),
                        ),
                      SizedBox(width: Defaults.defaultfontsize),
                      if (_product.productOnDiscount)
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Theme.of(context).backgroundColor,
                          child: _product.productDiscountType == 'Flat'
                              ? Text(_product.productDiscount.toString() + ' F',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Defaults.defaultfontsize - 5))
                              : Text(_product.productDiscount.toString() + ' %',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: Defaults.defaultfontsize - 5)),
                        )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Expanded(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            _product.productName,
            maxLines: 1,
            overflow: TextOverflow.clip,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: Defaults.defaultfontsize + 3),
          ),
          SizedBox(height: Defaults.defaultfontsize / 3),
          AmountBox(
            product: _product,
            isdetailpage: false,
            producthorizental: true,
          ),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: Defaults.defaultfontsize),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Qty',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: Defaults.defaultfontsize - 2),
                    ),
                    SizedBox(width: Defaults.defaultfontsize / 2),
                    Container(
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              countermethod(CounterType.Decreament, true);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 1,
                                  color: Colors.black38,
                                  style: BorderStyle.solid,
                                ),
                                color: Theme.of(context).accentColor,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(40),
                                    bottomLeft: Radius.circular(40)),
                              ),
                              height: Defaults.defaultfontsize + 2,
                              width: Defaults.defaultfontsize * 1.5,
                              child: Icon(
                                Icons.remove,
                                color: Colors.black54,
                                size: Defaults.defaultfontsize,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(
                                right: Defaults.defaultPadding / 3,
                                left: Defaults.defaultPadding / 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black38,
                                style: BorderStyle.solid,
                              ),
                            ),
                            //
                            child: Text(
                              _product.qty.toString(),
                              style: TextStyle(
                                  fontSize: Defaults.defaultfontsize - 2),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              countermethod(CounterType.Increament, true);
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.black38,
                                    style: BorderStyle.solid,
                                  ),
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(40),
                                      bottomRight: Radius.circular(40))),
                              height: Defaults.defaultfontsize + 2,
                              width: Defaults.defaultfontsize * 1.5,
                              child: Icon(
                                Icons.add,
                                color: Colors.black54,
                                size: Defaults.defaultfontsize,
                              ),
                            ),
                          ),

                          //Now Price
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: Defaults.defaultfontsize),
                TotalProductPrice(
                  totalprice: _product.price,
                  isdetailpage: false,
                  ishorizentalproduct: true,
                ),
                if (!false && !widget.horizental)
                  SizedBox(height: Defaults.defaultfontsize),
                if (!false && !widget.horizental)
                  buildCartAndQuick(
                      false, context, _product, widget.horizental),
              ],
            ),
          ),
          if (widget.horizental)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                    child: CustomeTextButton(
                  label: 'View Details',
                  onPressed: () {
                    Get.to(() => ProductdetailView(), arguments: _product);
                  },
                  color: Themes.lightBtnColor,
                )),
                SizedBox(width: Defaults.defaultPadding),
                Expanded(
                    child: CustomeTextButton(
                  label: 'Delete',
                  onPressed: () {
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
                            content: Text("Are you sure to delete Cart Itme"),
                            actions: [
                              CustomeTextButton(
                                label: 'Cancel',
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              CustomeTextButton(
                                label: 'Delete',
                                color: Themes.lightBackgroundColor,
                                onPressed: () async {
                                  controller.removeCart(
                                      index: widget.index, productId: _cartId);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.grey,
                )),
              ],
            )
        ]))
      ]),
    );
  }

  bool counterIncrement(CounterType counterType) {
    switch (counterType) {
      case CounterType.Increament:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  void countermethod(CounterType counterType, bool iscart) {
    switch (counterType) {
      case CounterType.Increament:
        setState(() {
          increment();
        });
        break;
      case CounterType.Decreament:
        setState(() {
          if (_product.qty > 1) {
            decrement();
          } else {
            defaultdata();
          }
        });
        break;
      default:
        setState(() {
          defaultdata();
        });
        break;
    }
  }

  void increment() {
    _product.qty++;
    _product.price = _product.productPrice * _product.qty;

    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    controller.calculateTotalsAmount();
  }

  void decrement() {
    _product.qty--;
    _product.price = _product.productPrice * _product.qty;

    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    controller.calculateTotalsAmount();
  }

  void defaultdata() {
    _product.qty = 1;
    _product.price = _product.productPrice * _product.qty;
    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    controller.calculateTotalsAmount();
  }
}
