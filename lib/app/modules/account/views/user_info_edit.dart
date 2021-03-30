import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/Widgets/inputs/text_fields.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/account/controllers/account_controller.dart';

dialogInfo(BuildContext context) {
  final userinfo = Get.find<AccountController>();
  return Container(
    height: Defaults.defaultPadding * 13,
    color: Theme.of(context).backgroundColor,
    padding: EdgeInsets.all(Defaults.defaultfontsize),
    child: Column(
      children: [
        Text(
          'User Information',
          style: TextStyle(
              fontSize: Defaults.defaultfontsize + 5, color: Colors.white),
        ),
        SizedBox(width: Defaults.defaultfontsize * 2),
        InputField(
          controller: userinfo.userInputName,
          context: context,
          hintText: 'Dispaly Name',
          label: 'Display Name',
        ),
        InputField(
            controller: userinfo.userInputPhone,
            context: context,
            hintText: 'Phone No',
            label: 'Phone No',
            textFieldColor: Colors.black),
        SizedBox(width: Defaults.defaultfontsize),
        Row(children: [
          Expanded(
              child: CustomeTextButton(
            label: 'Cancel',
            onPressed: () {
              Navigator.of(context).pop();
            },
            color: Theme.of(context).backgroundColor,
          )),
          SizedBox(width: Defaults.defaultfontsize / 2),
          Expanded(
              child: CustomeTextButton(
            label: 'Saved',
            onPressed: () {
              userinfo.updateUserInfo();
              Navigator.of(context).pop();
            },
            color: Theme.of(context).backgroundColor,
          ))
        ])
      ],
    ),
  );
}
