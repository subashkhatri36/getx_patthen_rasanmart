import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notificationpage_controller.dart';

class NotificationpageView extends GetView<NotificationpageController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NotificationpageView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'NotificationpageView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
