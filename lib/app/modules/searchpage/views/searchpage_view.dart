import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';

import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  final controller = Get.put(SearchpageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        leading: Text(''),
        actions: [
          Expanded(
              child: Row(children: [
            IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back),
            ),
            Expanded(
              child: TextFormField(
                  controller: controller.textEditingController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  autofocus: true,
                  decoration: new InputDecoration(
                    prefixIcon: new Icon(Icons.search),
                    hintText: Strings.searchMessage,
                    hintStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: Defaults.defaultfontsize),
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                  )),
            ),
            SizedBox(width: Defaults.defaultfontsize),
          ]))
        ],
      ),
      body: Obx(() => Column(
            children: [
              controller.productsearch?.length ?? 0 > 0
                  ? ListView.separated(
                      controller: controller.searchscroll,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Text(
                            controller.productsearch[index].productName);
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: controller.productsearch.length)
                  : Center(child: Text('Nodata')),
            ],
          )),
    );
  }
}
