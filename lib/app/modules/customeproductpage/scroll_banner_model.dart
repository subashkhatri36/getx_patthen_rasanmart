import 'package:flutter/material.dart';

class ScrollBanner {
  final String imagepath;
  final int index;
  ScrollBanner({
    @required this.imagepath,
    @required this.index,
  });

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ScrollBanner && o.imagepath == imagepath && o.index == index;
  }

  @override
  int get hashCode => imagepath.hashCode ^ index.hashCode;
}
