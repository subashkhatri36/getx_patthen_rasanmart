import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/otpverification_controller.dart';

class OtpverificationView extends GetView<OtpverificationController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OtpverificationView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'OtpverificationView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
