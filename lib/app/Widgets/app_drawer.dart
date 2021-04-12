import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_view.dart';
import 'package:rasan_mart/app/modules/checkout/controllers/delivery_controller.dart';
import 'package:rasan_mart/app/modules/deliveryviewall/views/deliveryviewall_view.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';
import 'package:rasan_mart/app/modules/orderdetails/views/orderdetails_view.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  List<String> imagePaths = [];
  onDeleteImage(int position) async {
    setState(() {
      imagePaths.removeAt(position);
    });
  }

  @override
  Widget build(BuildContext context) {
    Get.put(DeliveryController());
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: FontAwesomeIcons.home,
              text: 'Home',
              onTap: () {
                Get.off(() => HomeView());
                //Navigator.pushReplacementNamed(context, Routes.dashboard);
              }),
          Divider(),
          _createDrawerItem(
              onTap: () {
                Get.to(() => DeliveryviewallView());
              },
              icon: FontAwesomeIcons.firstOrder,
              text: 'My Order'),
          _createDrawerItem(
              onTap: () {
                Get.to(() => CartView());
              },
              icon: FontAwesomeIcons.shoppingCart,
              text: 'My cart'),
          Divider(),
          _createDrawerItem(
              onTap: () {}, icon: Icons.privacy_tip, text: 'privacy Policy'),
          _createDrawerItem(icon: Icons.info, text: 'About Us', onTap: () {}),
          Divider(),
          ListTile(
            title: Text('0.0.1'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: Themes.lightBackgroundColor,
          image: DecorationImage(
              fit: BoxFit.fitHeight,
              scale: 0.5,
              image: AssetImage('assets/images/logo.PNG'))),
      child: Padding(
        padding: const EdgeInsets.all(Defaults.defaultfontsize / 2),
        child: Text(
          Strings.appName,
          textAlign: TextAlign.left,
          style: TextStyle(color: Themes.lightPrimaryColor),
        ),
      ));
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
