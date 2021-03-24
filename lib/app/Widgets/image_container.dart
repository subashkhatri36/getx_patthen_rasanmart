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
    fit: fit != null ? fit: BoxFit.fitHeight,
    width: width,
    height: height,
    placeholder: (context, url) => Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          strokeWidth: 0.5,
        ),
        Text('Loading...')
      ],
    ),
    errorWidget: (context, url, error) => Icon(Icons.error),
  );
}
