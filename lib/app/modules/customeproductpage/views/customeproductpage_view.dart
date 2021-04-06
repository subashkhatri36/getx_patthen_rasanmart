import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/customeproductpage/views/customebodyview_view.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';

import '../controllers/customeproductpage_controller.dart';

class CustomeproductpageView extends GetView<CustomeproductpageController> {
  final customeController = Get.put(CustomeproductpageController());
  final homecontroller = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Obx(() => customeController.isProductContianerLioading.isTrue
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: Defaults.defaultPadding),
                      Text('Loading...')
                    ],
                  ))
                : ListView.builder(
                    controller: homecontroller.scrollController,
                    itemCount: customeController.productContianerList?.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      //checking file is banner or not first
                      customeController.index.value = index;

                      return Container(child: CustomebodyviewView()) ??
                          Text('No data Found');
                    })),
          ),
        ),
      ],
    );
  }
}
