import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


List<BottomNavigationBarItem> navItemsList = [
  BottomNavigationBarItem(
    icon: Icon(
      FontAwesomeIcons.home,
      //color: Themes.lightAccentColor,
    ),
    label: 'Home',

  ),

  BottomNavigationBarItem(
    icon: Icon(
      FontAwesomeIcons.tags,
      //color: Themes.lightAccentColor,
    ),
    label: 'Categories',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      FontAwesomeIcons.userCircle,
     // color: Themes.lightAccentColor,
    ),
    label: 'Account',
  ),
];


