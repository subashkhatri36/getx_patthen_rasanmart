import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/addAddress/controllers/add_address_controller.dart';
import 'package:rasan_mart/app/modules/addAddress/views/add_address_view.dart';
import 'package:get/get.dart';

class AddressSelectedWidget extends StatelessWidget {
  const AddressSelectedWidget({
    Key key,
    @required this.controller,
    this.isadd = false,
    this.ischange = false,
  }) : super(key: key);

  final AddAddressController controller;
  final isadd, ischange;

  @override
  Widget build(BuildContext context) {
    String address = '';
    String selectedaddress = '';

    controller.newAddress.forEach((element) {
      if (element.isSelected)
        selectedaddress = element.fullAddress;
      else
        address = element.fullAddress;
    });

    return controller.newAddress.length > 0
        ? InkWell(
            onTap: () {
              Get.to(() => AddAddressView(), arguments: [isadd, ischange]);
            },
            child: Container(
                height: Defaults.defaultPadding * 6,
                padding: EdgeInsets.all(Defaults.defaultPadding / 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Address',
                          style: TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                              fontSize: Defaults.defaultfontsize + 3),
                          textAlign: TextAlign.left,
                        ),
                        !ischange
                            ? Icon(
                                Icons.arrow_right_alt,
                                size: 30,
                                color: Themes.lightSalesolor,
                              )
                            : Icon(
                                Icons.change_history,
                                size: 30,
                                color: Themes.lightSalesolor,
                              )
                      ],
                    ),
                    Text(
                      controller.newAddress.length > 0
                          ? selectedaddress
                          : address,
                      style: TextStyle(fontSize: Defaults.defaultfontsize),
                      textAlign: TextAlign.left,
                    ),
                  ],
                )),
          )
        : Container();
  }
}
