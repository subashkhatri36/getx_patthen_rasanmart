import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/customeproductpage_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/views/customeproductpage_view.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';

import '../controllers/product_category_controller.dart';

class ProductCategoryView extends GetView<ProductCategoryController> {
  final contro = Get.find<CustomeproductpageController>();
  final String arg = Get.arguments;
  final productCat = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        productCat.subcategorypage.value = true;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text(arg),
        ),
        body: CustomeproductpageView(),
      ),
    );
  }
}
