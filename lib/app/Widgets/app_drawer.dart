
import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';

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
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.dashboard,
              text: 'Dashboard',
              onTap: () {
                //Navigator.pushReplacementNamed(context, Routes.dashboard);
              }),
          Divider(),
          _createDrawerItem(onTap: () {}, icon: Icons.thumb_up, text: 'Like'),
          _createDrawerItem(icon: Icons.info, text: 'About Us', onTap: () {}),
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
