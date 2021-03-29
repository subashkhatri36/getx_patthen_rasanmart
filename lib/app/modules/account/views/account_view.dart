import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';

import '../controllers/account_controller.dart';

class AccountView extends GetView<AccountController> {
  final user = Get.put(AccountController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: user.user != null
          ? Column(
              children: [
                AccountHeader(),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                      padding: EdgeInsets.all(Defaults.defaultPadding - 5),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Themes.lightcounterbtnColor)),
                      child: Row(
                        children: [
                          Icon(Icons.add),
                          SizedBox(width: Defaults.defaultPadding / 2),
                          Text('Add Address')
                        ],
                      )),
                ),
                Container(
                  height: Defaults.defaultPadding * 5,
                  padding: EdgeInsets.all(Defaults.defaultPadding / 2),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Text('Address...');
                      }),
                ),
                Container(
                    padding: EdgeInsets.all(Defaults.defaultPadding - 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Themes.lightcounterbtnColor)),
                    child: Row(
                      children: [
                        Icon(Icons.shopping_bag),
                        SizedBox(width: Defaults.defaultPadding / 2),
                        Text(
                          'Current Order',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: Defaults.defaultPadding * 4,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 2,
                      itemBuilder: (context, index) {
                        return Text('Order1...');
                      }),
                ),
                CustomeTextButton(
                  label: 'Log Out',
                  onPressed: () {
                    user.LogOut();
                  },
                  color: Theme.of(context).backgroundColor,
                )
              ],
            )
          : Container(
              height: MediaQuery.of(context).size.height - 75,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'You can have Your Own Account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CustomeTextButton(
                    label: 'Sing In',
                    onPressed: () {
                      Get.to(() => AuthenticationView());
                    },
                    color: Theme.of(context).backgroundColor,
                  )
                ],
              ),
            ),
    );
  }
}

class AccountHeader extends StatelessWidget {
  const AccountHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userInfo = Get.find<AccountController>();
    return Stack(children: [
      Obx(() => Container(
          padding: EdgeInsets.only(top: Defaults.defaultfontsize),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .30,
          color: Theme.of(context).backgroundColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: Defaults.defaultfontsize / 2),
              CircleAvatar(
                foregroundColor: Theme.of(context).primaryColor,
                backgroundColor: Colors.white,
                radius: 60,
                child: Image.asset(
                  'assets/images/logo.PNG',
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(height: Defaults.defaultfontsize),
              Text(
                userInfo.userName.value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultPadding / 1.8,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: Defaults.defaultfontsize / 3),
              Text(
                userInfo.userEmail.value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultPadding - 4,
                    color: Theme.of(context).primaryColor),
              ),
              SizedBox(height: Defaults.defaultfontsize / 3),
              Text(
                userInfo.userPhone.value,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Defaults.defaultPadding / 1.8,
                    color: Theme.of(context).primaryColor),
              ),
            ],
          ))),
      Positioned(
        top: 2,
        right: 2,
        child: IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.pencilAlt,
              color: Colors.white,
            )),
      )
    ]);
  }
}
