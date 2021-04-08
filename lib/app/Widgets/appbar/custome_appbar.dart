import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/notification_icons_circulation.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_view.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/home/controllers/home_controller.dart';
import 'package:rasan_mart/app/modules/notificationpage/controllers/notification_controller.dart';
import 'package:rasan_mart/app/modules/notificationpage/views/notificationpage_view.dart';
import 'package:rasan_mart/app/modules/searchpage/views/searchpage_view.dart';

AppBar buildAppBar(
    BuildContext context, GlobalKey<ScaffoldState> globalScafold) {
  final cart = Get.find<CartController>();
  final notification = Get.find<NotificationController>();
  return AppBar(
    leading: Text(''),
    backgroundColor: Theme.of(context).backgroundColor,
    actions: [
      Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                globalScafold.currentState.openDrawer();
                //  Scaffold.of(context).openDrawer();
              },
              icon: Icon(
                Icons.sort,
                size: 30,
              ),
            ),
            Get.find<HomeController>().searchBar.value
                ? Row(
                    children: [
                      SizedBox(width: Defaults.defaultPadding),
                      Icon(Icons.search),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => SearchpageView());
                          //Navigator.of(context).pushNamed('/search');
                        },
                        child: Text(
                          Strings.searchMessage,
                          style: TextStyle(
                              fontSize: Defaults.defaultfontsize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                : RichText(
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
                Obx(
                  () => Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => NotificationpageView());
                        },
                        child: Notification(
                          length: notification.notification.value ?? 0,
                        ),
                      ),
                      SizedBox(width: Defaults.defaultfontsize / 2),
                      GestureDetector(
                        onTap: () {
                          Get.to(() => CartView());
                        },
                        child: ShoppingCart(
                          length: cart.cartList?.length ?? 0,
                        ),
                      ),
                    ],
                  ),
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

class Notification extends StatefulWidget {
  final int length;
  const Notification({
    Key key,
    this.length,
  }) : super(key: key);

  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return widget.length > 0
        ? IconWithNotification(
            icon: Icons.notifications,
            notification: widget.length.toString(),
          )
        : Icon(
            Icons.notifications,
            size: 30,
          );
  }
}

class ShoppingCart extends StatefulWidget {
  final int length;
  const ShoppingCart({
    Key key,
    this.length,
  }) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    return widget.length > 0
        ? IconWithNotification(
            icon: Icons.shopping_cart,
            notification: widget.length.toString(),
          )
        : Icon(
            Icons.shopping_cart,
            size: 30,
          );
  }
}
