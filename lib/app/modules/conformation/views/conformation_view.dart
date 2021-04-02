import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/conformation_controller.dart';

class ConformationView extends GetView<ConformationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ConformationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'ConformationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
