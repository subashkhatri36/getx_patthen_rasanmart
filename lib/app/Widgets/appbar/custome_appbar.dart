import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/notification_icons_circulation.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';
import 'package:rasan_mart/app/modules/searchpage/views/searchpage_view.dart';

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Theme.of(context).backgroundColor,
    actions: [
      Get.find<HomeController>().searchBar.value
          ? Expanded(
              child: Container(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => SearchpageView());
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.search),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed('/search');
                        },
                        child: Text(
                          Strings.searchMessage,
                          style: TextStyle(
                              fontSize: Defaults.defaultfontsize + 3,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.notifications),
                          SizedBox(width: Defaults.defaultfontsize),
                          Icon(Icons.shopping_cart),
                          SizedBox(width: Defaults.defaultfontsize / 2),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              //Here the notification Icon and cart icon
            )
          : Container(
              width: MediaQuery.of(context).size.width * .7,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: new TextSpan(
                      children: <TextSpan>[
                        new TextSpan(
                            text: 'Rasan ',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Themes.lightBtnColor,
                                fontSize: Defaults.defaultfontsize * 2)),
                        new TextSpan(
                            text: 'Mart',
                            style: new TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.pink[900],
                                fontSize: Defaults.defaultfontsize * 2)),
                      ],
                    ),
                  ),
                  SizedBox(width: Defaults.defaultfontsize),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconWithNotification(
                        icon: Icons.shopping_cart,
                        notification: '1',
                      ),
                      SizedBox(width: Defaults.defaultfontsize),
                      IconWithNotification(
                        icon: Icons.notifications,
                        notification: '1',
                      ),
                      SizedBox(width: Defaults.defaultfontsize / 2),
                    ],
                  ),
                ],
              ),
            )
    ],
  );
}
