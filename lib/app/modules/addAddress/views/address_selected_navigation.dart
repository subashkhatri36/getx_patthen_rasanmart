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

    if (controller.newAddress != null)
      controller.newAddress.forEach((element) {
        if (element.isSelected) {
          selectedaddress = element.fullAddress;
          controller.selectedAddressString.value = selectedaddress;
        } else
          address = element.fullAddress;
      });
    int v = controller.newAddress?.length ?? 0;

    return v > 0
        ? InkWell(
            onTap: () {
              Get.to(() => AddAddressView(), arguments: [isadd, ischange]);
            },
            child: Container(
                height: ischange
                    ? Defaults.defaultPadding * 4.6
                    : Defaults.defaultPadding * 5,
                padding: EdgeInsets.all(Defaults.defaultPadding / 2),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          ischange ? 'Shipping Address' : 'Selected Address',
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
                            : Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: Defaults.defaultfontsize,
                                    vertical: Defaults.defaultfontsize / 5),
                                decoration: BoxDecoration(
                                  color: Themes.lightcounterbtnColor,
                                  borderRadius: BorderRadius.circular(
                                      Defaults.defaultfontsize),
                                  border: Border.all(
                                      color: Themes.lightcounterbtnColor),
                                ),
                                child: Text(
                                  'Change',
                                  style: TextStyle(
                                      fontSize: Defaults.defaultfontsize - 4,
                                      fontWeight: FontWeight.bold),
                                ))
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
