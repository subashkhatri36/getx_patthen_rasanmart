import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/Product/product_horizental.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/searchpage/controllers/searchpage_controller.dart';

class SearchpageView extends StatelessWidget {
  final controllerSearch = Get.find<SearchpageController>();
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
                  onFieldSubmitted: (value) {
                    controllerSearch.doSearch();
                  },
                  controller: controllerSearch.textEditingController,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                  autofocus: true,
                  decoration: new InputDecoration(
                    suffixIcon: IconButton(
                        onPressed: () => controllerSearch.doSearch(),
                        icon: new Icon(Icons.search)),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => controllerSearch.isLoading.isTrue
                ? Center(child: Text('Searching...'))
                : (controllerSearch.productsearch?.length ?? 0) > 0
                    ? ListView.separated(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return ProductHorizental(
                            product: controllerSearch.productsearch[index],
                            cartId: '',
                            index: index,
                            horizental: false,
                          );
                        },
                        separatorBuilder: (context, index) => Divider(),
                        itemCount: controllerSearch.productsearch.length)
                    : Expanded(
                        child: Center(
                            child: Text(
                          'No data Found',
                          style: TextStyle(
                              fontSize: Defaults.defaultPadding,
                              color: Themes.lightcounterbtnColor,
                              fontWeight: FontWeight.bold,
                              fontStyle: FontStyle.italic),
                        )),
                      ),
          )
          // : Center(child: Text('Nodata')),
        ],
      ),
    );
  }
}
