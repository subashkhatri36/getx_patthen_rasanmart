import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/buttons/buttons_widgets.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';

import '../controllers/conformdelivery_controller.dart';

class ConformdeliveryView extends GetView<ConformdeliveryController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.done,
              size: 90,
              color: Colors.white,
            ),
            Text(
              'Thank You!\nWe Recieved Your Order',
              style: TextStyle(
                  fontSize: 20, color: Theme.of(context).primaryColor),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: Defaults.defaultPadding),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.delivery_dining,
                  color: Colors.white,
                  size: 50,
                ),
                SizedBox(width: Defaults.defaultPadding),
                Text(
                  'Note*\nYour Order Product(s) arrived with 48 hours.',
                  style: TextStyle(
                      fontSize: Defaults.defaultfontsize,
                      color: Theme.of(context).primaryColor),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Defaults.defaultfontsize,
                  horizontal: Defaults.defaultfontsize),
              child: TextButton(
                autofocus: true,
                onPressed: () {
                  Get.off(() => HomeView());
                },
                style: TextButton.styleFrom(
                  primary: Colors.black, // foreground/text
                  backgroundColor: Colors.white,
                ),
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Go To Home', style: TextStyle(color: Colors.black)),
                  SizedBox(width: Defaults.defaultPadding),
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black,
                  )
                ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
