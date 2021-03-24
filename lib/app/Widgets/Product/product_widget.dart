import 'dart:core';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rasan_mart/app/Widgets/Product/amount_box.dart';
import 'package:rasan_mart/app/Widgets/image_container.dart';
import 'package:rasan_mart/app/Widgets/quantity_and_totalprice_container.dart';
import 'package:rasan_mart/app/Widgets/Product/sale_and_discount.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productdetail/views/productdetail_view.dart';

class ProductWidget extends StatefulWidget {
  final ContianerType contianerType;
  final Product product;
  //final mainIndex;
  //final index;

  const ProductWidget({
    Key key,
    @required this.product,
    @required this.contianerType,
  }) : super(key: key);

  @override
  _ProductWidgetState createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  int qty = 1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 0.41,
        decoration: buildBoxDecoration(
            bgcolor: widget.product.backgroundColor.isEmpty
                ? Colors.transparent
                : HexColor(widget.product.backgroundColor),
            shadow: false,
            round: false),
        margin: EdgeInsets.all(Defaults.defaultfontsize / 3),
        padding: EdgeInsets.all(Defaults.defaultfontsize),
        child: Stack(children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: Defaults.defaultfontsize / 6),
                child: Hero(
                    tag: new Text(widget.product.productId),
                    child: imageContainer(
                      path: widget.product.productImages[0],
                      context: context,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * .07,
                    )),
              ),
              SizedBox(height: Defaults.defaultfontsize / 2),
              Text(
                widget.product.productName,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.clip,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultfontsize - 3),
              ),
              SizedBox(height: Defaults.defaultfontsize),
              AmountBox(
                product: widget.product,
                isdetailpage: false,
              ),
              QuantityAndTotalpriceContainer(
                product: widget.product,
                isdetailpage: false,
              ),
            ],
          ),
          if (widget.product.productOnSale)
            SalesAndDiscount(
              isSaleType: true,
              discount: 0,
              discountType: 'No',
              isgridview: returnvalue(widget.contianerType),
            ),
          if (widget.product.productOnDiscount)
            SalesAndDiscount(
              isSaleType: false,
              discount: widget.product.productDiscount,
              discountType: widget.product.productDiscountType,
              isgridview: returnvalue(widget.contianerType),
            ),
        ]));
  }
}

bool returnvalue(ContianerType contianerType) {
  return contianerType == ContianerType.HorizentalLayout ? false : true;
}
