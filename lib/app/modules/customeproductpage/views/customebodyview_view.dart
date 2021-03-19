import 'package:flutter/material.dart';

import 'package:get/get.dart';
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
    print('value');
    print(list);
    switch (list.contianerType) {
      case ContianerType.SearchBar:
        print('try to print searchbar');
        return SearchBarIcon(
          val: list,
        );
        break;

      /*

      case ContianerType.HorizentalLayout:
        Color color = list.backgroundColor;
        String title = plist.containerTitle;
        List<String> plist = list.productIdList;
        return HorizentalProductContainer(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
        );

      case ContianerType.GridviewLayout:
        Color color = list.backgroundColor;
        String title = list.containerTitle;
        List<String> plist = list.productIdList;
        return GridViewProduct(
          containerTitle: title,
          backgroundColor: color,
          productIdList: plist,
        );

      case ContianerType.BannerLayout:
        return BannerScrollImage();
        break;
      case ContianerType.Category:
        return CategoriesGridView(
          istabclick: false,
        );
        break;
        */
      default:
        return Container();
        break;
    }
  }
}
