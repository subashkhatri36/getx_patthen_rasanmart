import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget imageContainer({
  @required String path,
  @required BuildContext context,
  @required double width,
  @required double height,
  BoxFit fit,
}) {
  return CachedNetworkImage(
    imageUrl: path,
    fadeInDuration: Duration(milliseconds: 1),
    fit: BoxFit.fitHeight,
    width: width,
    height: height,
    placeholder: (context, url) => Container(
      width: width,
      height: height,
      child: Column(
        children: [
          CircularProgressIndicator(
            strokeWidth: 0.5,
          ),
        ],
      ),
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
