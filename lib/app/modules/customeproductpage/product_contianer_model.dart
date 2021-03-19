import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/enum/enum_convert.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';

class ProductContianer {
  final Color backgroundColor;
  final String containerTitle;
  final List<String> productIdList;
  final int layoutType;
  ContianerType contianerType;
  final int layoutindex;

  EnumConvertor enumConvertor = EnumConvertor();

  ProductContianer({
    @required this.layoutindex,
    @required this.layoutType,
    @required this.backgroundColor,
    @required this.containerTitle,
    @required this.productIdList,
  }) {
    this.contianerType = enumConvertor.containerConvert(layoutType);
  }
  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ProductContianer &&
        o.backgroundColor == backgroundColor &&
        o.containerTitle == containerTitle &&
        listEquals(o.productIdList, productIdList) &&
        o.layoutType == layoutType &&
        o.contianerType == contianerType &&
        o.layoutindex == layoutindex;
  }

  @override
  int get hashCode {
    return backgroundColor.hashCode ^
        containerTitle.hashCode ^
        productIdList.hashCode ^
        layoutType.hashCode ^
        contianerType.hashCode ^
        layoutindex.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'backgroundColor': backgroundColor?.value,
      'containerTitle': containerTitle,
      'productIdList': productIdList,
      'layoutType': layoutType,
      'layoutindex': layoutindex,
    };
  }

  factory ProductContianer.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return ProductContianer(
      backgroundColor: Color(map['backgroundColor']),
      containerTitle: map['containerTitle'],
      productIdList: List<String>.from(map['productIdList']),
      layoutType: map['layoutType'],
      layoutindex: map['layoutindex'],
    );
  }

  @override
  String toString() {
    return 'ProductContianer(backgroundColor: $backgroundColor, containerTitle: $containerTitle, productIdList: $productIdList, layoutType: $layoutType, contianerType: $contianerType, layoutindex: $layoutindex)';
  }
}
