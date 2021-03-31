import 'dart:async';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';

class ViewAddressWidget extends StatelessWidget {
  const ViewAddressWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controllerAddress = Get.find<AddAddressController>();

    return Obx(() {
      return controllerAddress.isAddressLoad.value
          ? CircularProgressIndicator()
          : Container(
              padding: EdgeInsets.only(top: Defaults.defaultPadding / 2),
              child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: controllerAddress.newAddress?.length ?? 0,
                  itemBuilder: (context, index) {
                    AddressModel addressModel =
                        controllerAddress.newAddress[index];
                    return AddressListTile(
                        addressModel: addressModel, index: index);
                  }),
            );
    });
  }
}

class AddressListTile extends StatelessWidget {
  const AddressListTile({
    Key key,
    @required this.addressModel,
    this.index,
  }) : super(key: key);

  final AddressModel addressModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    final controllerAddress = Get.find<AddAddressController>();

    if (addressModel.isSelected) controllerAddress.selectedIndex.value = index;
    return GestureDetector(
      onDoubleTap: () {
        if (controllerAddress.newAddress.length > 0) {
          //controllerAddress.newAddress[controllerAddress.selectedIndex.value]
          //  .isSelected = false;
          //controllerAddress.newAddress[index].isSelected = true;
          controllerAddress.changeList(index);

          print('listening');
          print(controllerAddress.selectedIndex.value);
          print(index);
        }
      },
      child: Container(
        child: ListTile(
          title: Text(
            addressModel.fullAddress,
            style: TextStyle(
                fontSize: Defaults.defaultfontsize,
                fontWeight: addressModel.isSelected
                    ? FontWeight.bold
                    : FontWeight.normal),
            textAlign: TextAlign.left,
          ),
          trailing: addressModel.isSelected
              ? Icon(
                  FontAwesomeIcons.check,
                  color: Themes.lightSalesolor,
                )
              : null,
        ),
      ),
    );
  }
}
