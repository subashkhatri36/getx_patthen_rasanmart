import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/amount_box.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/image_container.dart';
import 'package:rasan_mart/app/Widgets/quantity_and_totalprice_container.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productdetail/views/productdetail_view.dart';

class ProductHorizental extends StatefulWidget {
  final Product product;
  final int index;
  final String cartId;

  const ProductHorizental(
      {Key key,
      @required this.product,
      @required this.index,
      @required this.cartId})
      : super(key: key);

  @override
  _ProductHorizentalState createState() => _ProductHorizentalState();
}

class _ProductHorizentalState extends State<ProductHorizental> {
  Product get _product => widget.product;
  String get _cartId => widget.cartId;
  final controller = Get.find<CartController>();

  @override
  Widget build(BuildContext context) {
      
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Defaults.defaultfontsize,
        vertical: Defaults.defaultPadding / 2,
      ),
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
          QuantityAndTotalpriceContainer(
              product: _product,
              isdetailpage: false,
              isproducthorizental: true),
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
                  controller.removeCart(
                      index: widget.index, productId: _cartId);
                },
                color: Colors.grey,
              )),
            ],
          )
        ]))
      ]),
    );
  }
}
