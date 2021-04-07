import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/addAddress/views/addaddress_widgets.dart';
import 'package:rasan_mart/app/modules/addAddress/views/view_address_widget.dart';

import '../controllers/add_address_controller.dart';

class AddAddressView extends GetView<AddAddressController> {
  final List<dynamic> addAddress = Get.arguments;
  final controller = Get.put(AddAddressController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (controller.isAddressEdit.value) {
          controller.isAddressEdit.value = false;
          return false;
        } else {
          Get.back();
          return true;
        }
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            title: Text(addAddress[0] ? 'Add Address' : 'View Address'),
          ),
          body: Obx(
            () => controller.isAddressEdit.value || addAddress[0]
                ? AddAddressWidget()
                : ViewAddressWidget(change: addAddress[1]),
          )),
    );
  }
}
