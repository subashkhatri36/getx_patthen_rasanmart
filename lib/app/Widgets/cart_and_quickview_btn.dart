import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';

Container buildCartAndQuick(bool isdetailpage, BuildContext context) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.center,
          padding: isdetailpage
              ? EdgeInsets.symmetric(
                  horizontal: Defaults.defaultPadding * 2,
                  vertical: Defaults.defaultfontsize / 2,
                )
              : EdgeInsets.all(Defaults.defaultfontsize / 4),
          decoration: buildBoxDecoration(
              bgcolor: isdetailpage
                  ? Theme.of(context).backgroundColor
                  : Colors.grey[300],
              round: true,
              shadow: false),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart,
                size: isdetailpage
                    ? Defaults.defaultPadding
                    : Defaults.defaultfontsize - 2,
                color: isdetailpage
                    ? Theme.of(context).primaryColor
                    : Colors.black54,
              ),
              Text(
                'Add To Cart',
                style: TextStyle(
                    color: isdetailpage
                        ? Theme.of(context).primaryColor
                        : Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: isdetailpage
                        ? Defaults.defaultPadding
                        : Defaults.defaultfontsize / 2),
              )
            ],
          ),
        ),
        if (!isdetailpage) SizedBox(width: Defaults.defaultfontsize / 2),
        if (!isdetailpage)
          Container(
            padding: EdgeInsets.all(Defaults.defaultfontsize / 4),
            decoration:
                buildBoxDecoration(bgcolor: null, round: true, shadow: false),
            child: Row(
              children: [
                Icon(
                  FontAwesomeIcons.eye,
                  size: Defaults.defaultfontsize - 2,
                ),
                SizedBox(width: 4),
                Text(
                  'QUICK VIEW',
                  style: TextStyle(fontSize: Defaults.defaultfontsize / 2),
                )
              ],
            ),
          ),
      ],
    ),
  );
}
