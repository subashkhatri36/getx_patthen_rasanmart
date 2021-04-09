import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Product/product_horizental.dart';
import 'package:rasan_mart/app/Widgets/Product/product_widget.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';

import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

import '../controllers/productview_controller.dart';

class ProductviewView extends GetView<ProductviewController> {
  final bool horizental;
  final List<Product> productList=Get.arguments;
  final String title;
  //@required this.productList
  ProductviewView({this.title,this.horizental = true, });
  @override
  Widget build(BuildContext context) {
    // final productController = Get.find<ProductController>();
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          backgroundColor: Theme.of(context).backgroundColor,
        ),
        body: horizental
            ? ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Product oneproduct = productList[index];
                  return ProductHorizental(
                    product: oneproduct,
                    cartId: '',
                    index: 0,
                    horizental: false,
                  );
                },
                separatorBuilder: (context, index) => Divider(),
                itemCount: productList.length)
            : GridView.count(
                childAspectRatio: .8,
                shrinkWrap: true,
                crossAxisSpacing: 2,
                mainAxisSpacing: 3,
                crossAxisCount: 2,
                children: List.generate(
                  productList.length,
                  (index) {
                    Product oneproduct = productList[index];
                    return ProductWidget(
                      product: oneproduct,
                      contianerType: ContianerType.GridviewLayout,
                    );
                  },
                )));
  }
}
