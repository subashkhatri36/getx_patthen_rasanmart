import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Gridview_categories.dart';
import 'package:rasan_mart/app/Widgets/Scroll_banner.dart';
import 'package:rasan_mart/app/Widgets/horizental_product_container.dart';
import 'package:rasan_mart/app/Widgets/search_bar_icons.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/controllers/customeproductpage_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';

class CustomebodyviewView extends GetView {
  final productContainerController = Get.find<CustomeproductpageController>();

  @override
  Widget build(BuildContext context) {
    ProductContianer list = productContainerController
        .productContianerList[productContainerController.index.value];

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
        int index = productContainerController.index.value;
        productContainerController.increaseindex(index);
        return HorizentalProductContainer(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
          index: index,
        );
      /*

      case ContianerType.GridviewLayout:
        Color color = list.backgroundColor;
        String title = list.containerTitle;
        List<String> plist = list.productIdList;
        return GridViewProduct(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
        );
         */

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
