import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/addAddress/views/addaddress_widgets.dart';
import 'package:rasan_mart/app/modules/addAddress/views/view_address_widget.dart';

import '../controllers/add_address_controller.dart';

class AddAddressView extends GetView<AddAddressController> {
  final bool addAddress = Get.arguments ?? true;
  final controller = Get.put(AddAddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).backgroundColor,
        title: Text(addAddress ? 'Add Address' : 'View Address'),
      ),
      body: addAddress ? AddAddressWidget() : ViewAddressWidget(),
    );
  }
}
