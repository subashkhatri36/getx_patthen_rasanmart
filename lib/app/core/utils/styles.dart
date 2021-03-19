import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';

BoxDecoration buildBoxDecoration(
    {@required Color bgcolor, @required bool round, @required bool shadow}) {
  return BoxDecoration(
    color: bgcolor != null ? bgcolor : Colors.transparent,
    boxShadow: shadow
        ? [
            BoxShadow(
                offset: Offset(0.0, 0.1), blurRadius: 1.0, spreadRadius: 0.1)
          ]
        : [],
    borderRadius: round
        ? BorderRadius.circular(Defaults.defaultfontsize / 2)
        : BorderRadius.circular(0),
    border: Border.all(
      width: 1,
      color: Colors.black38,
      style: BorderStyle.solid,
    ),
  );
}
