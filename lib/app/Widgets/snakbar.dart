import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';

class CustomeSnackbar {
  final String title;
  final String message;
  final Icon icon;
  final Color backgroundColor;

  CustomeSnackbar({
    this.title,
    this.message,
    this.icon,
    this.backgroundColor,
  }) {
    Get.snackbar(title, message,
        icon: icon,
        backgroundColor: backgroundColor ?? Themes.lightBackgroundColor,
        snackPosition: SnackPosition.BOTTOM,
        margin: EdgeInsets.symmetric(
            vertical: Defaults.defaultfontsize,
            horizontal: Defaults.defaultfontsize / 2));
  }
}
