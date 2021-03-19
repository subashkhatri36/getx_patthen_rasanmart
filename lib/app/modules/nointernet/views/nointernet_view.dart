import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/nointernet_controller.dart';

class NointernetView extends GetView<NointernetController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NointernetView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NointernetView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
