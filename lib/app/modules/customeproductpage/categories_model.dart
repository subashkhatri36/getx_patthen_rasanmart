import 'package:flutter/material.dart';

class Categories {
  final String categoryName;
  final String categoryPath;

  Categories({
    @required this.categoryName,
    @required this.categoryPath,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Categories &&
        o.categoryName == categoryName &&
        o.categoryPath == categoryPath;
  }

  @override
  int get hashCode => categoryName.hashCode ^ categoryPath.hashCode;
}
