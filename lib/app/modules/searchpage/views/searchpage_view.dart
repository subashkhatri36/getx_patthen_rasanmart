import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/searchpage_controller.dart';

class SearchpageView extends GetView<SearchpageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SearchpageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SearchpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
