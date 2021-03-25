import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';

class CustomeSnackbar {
  final String title;
  final String message;
  final Icon icon;

  CustomeSnackbar({
    this.title,
    this.message,
    this.icon,
  }) {
    Get.snackbar(title, message,
        borderColor: Themes.lightBackgroundColor,
        borderWidth: 1,
        icon: icon,
        backgroundColor: Themes.lightPrimaryColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
            vertical: Defaults.defaultfontsize,
            horizontal: Defaults.defaultfontsize / 2));
  }
}
