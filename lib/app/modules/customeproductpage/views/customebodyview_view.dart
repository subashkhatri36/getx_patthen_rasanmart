import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Product/Gridview_categories.dart';
import 'package:rasan_mart/app/Widgets/Product/Gridview_product_container.dart';
import 'package:rasan_mart/app/Widgets/Scroll_banner.dart';
import 'package:rasan_mart/app/Widgets/Product/horizental_product_container.dart';
import 'package:rasan_mart/app/Widgets/search_bar_icons.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/customeproductpage_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/gridview_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/product_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';

class CustomebodyviewView extends StatefulWidget {
  @override
  _CustomebodyviewViewState createState() => _CustomebodyviewViewState();
}

class _CustomebodyviewViewState extends State<CustomebodyviewView> {
  final productContainerController = Get.find<CustomeproductpageController>();

  int _productindex = -1;
  // int _preproduct = 0;

  int _gridindex = 0;
  @override
  void initState() {
    //productContainerController.onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductContianer list = productContainerController
        .productContianerList[productContainerController.index.value];
    Get.put(ProductController());
    Get.put(GridviewController());

    // Get.put(SplashController());

    switch (list.contianerType) {
      case ContianerType.SearchBar:
        return SearchBarIcon(
          val: list,
        );
        break;

      case ContianerType.HorizentalLayout:
        Color color = list.backgroundColor;
        String title = list.containerTitle;
        List<String> plist = list.productIdList;
        setState(() {
          _productindex = productContainerController.productindex.value;
          productContainerController.productincreaseindex();
        });
        // print('product ' + _productindex.toString());
        try {
          return HorizentalProductContainer(
            containerTitle: title,
            backgroundColor: color,
            productIdList: plist,
          );
        } catch (error) {
          return Container();
        }

        return HorizentalProductContainer(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
        );

      case ContianerType.GridviewLayout:
        Color color = list.backgroundColor;
        String title = list.containerTitle;
        List<String> plist = list.productIdList;
        setState(() {
          _gridindex = productContainerController.gridIndex.value;
          productContainerController.gridincreaseindex();
        });
        return GridViewProduct(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
          index: _gridindex++,
        );

      case ContianerType.BannerLayout:
        return BannerScrollImage();
        break;

      case ContianerType.Category:
        return CategoriesGridView(
          false,
        );
        break;

      default:
        return Container();
        break;
    }
  }
}
