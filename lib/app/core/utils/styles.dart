import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enum_convert.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';

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

String discountString(
    {@required String discountType, @required String discountAmount}) {
  EnumConvertor enumConvertor = EnumConvertor();
  DiscountType discount = enumConvertor.discountConvert(discountType);
  switch (discount) {
    case DiscountType.Flat:
      return discountAmount + ' F';
      break;
    case DiscountType.Percentage:
      return discountAmount + '%';
      break;
    default:
      return '';
      break;
  }
}
