import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/amount_box.dart';
import 'package:rasan_mart/app/Widgets/Product/cart_and_quickview_btn.dart';
import 'package:rasan_mart/app/Widgets/Product/horizental_product_container.dart';
import 'package:rasan_mart/app/Widgets/Product/product_detail_container.dart';
import 'package:rasan_mart/app/Widgets/quantity_and_totalprice_container.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enum_convert.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';
import 'package:rasan_mart/app/data/local_data/dummy_data.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/productdetail/views/product_images_details.dart';

class ProductdetailView extends StatefulWidget {
  final Product productDetails = Get.arguments;
  @override
  _ProductdetailViewState createState() => _ProductdetailViewState();
}

class _ProductdetailViewState extends State<ProductdetailView> {
  EnumConvertor enumConvertor = EnumConvertor();
  Product get _product => widget.productDetails;
  @override
  Widget build(BuildContext context) {
    //  Product productDetail = Get.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(
          _product.productName,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: Defaults.defaultfontsize + 5,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductImageDetails(
                  product: _product,
                ),
                SizedBox(height: Defaults.defaultfontsize / 2),
                Container(
                    decoration: buildBoxDecoration(
                        bgcolor: Theme.of(context).backgroundColor,
                        round: false,
                        shadow: false),
                    margin: EdgeInsets.only(left: Defaults.defaultfontsize),
                    padding: EdgeInsets.all(Defaults.defaultfontsize / 2),
                    child: Text(
                      discountString(
                            discountType: _product.productDiscountType,
                            discountAmount: _product.productDiscount.toString(),
                          ) +
                          ' OFF',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.only(left: Defaults.defaultfontsize),
                  child: AmountBox(
                    product: _product,
                    isdetailpage: true,
                  ),
                ),
                SizedBox(height: 10),
                ProductDetailContainer(
                    productDetail: _product.productDescription),
                QuantityAndTotalpriceContainer(
                  product: _product,
                  isdetailpage: true,
                ),
                SizedBox(height: 10),
                Container(
                  margin: EdgeInsets.all(Defaults.defaultPadding),
                  padding: EdgeInsets.all(Defaults.defaultPadding),
                  decoration: buildBoxDecoration(
                      bgcolor: Colors.transparent, round: true, shadow: false),
                  child: buildCartAndQuick(true, context, _product),
                ),
                SizedBox(height: 10),
                HorizentalProductContainer(
                  containerTitle: 'Similar Products',
                  backgroundColor: Colors.transparent,
                  productIdList: _product.similarproduct,
                ),
                SizedBox(height: Defaults.defaultPadding)
              ],
            )),
      ),
    );
  }
}
