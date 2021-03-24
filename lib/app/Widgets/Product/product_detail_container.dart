import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';

class ProductDetailContainer extends StatelessWidget {
  final List<String> productDetail;

  const ProductDetailContainer({Key key, @required this.productDetail})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: Defaults.defaultfontsize),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          Strings.productDescription,
          textAlign: TextAlign.left,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Defaults.defaultfontsize * 1.5,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: productDetail
              .map(
                (e) => Container(
                  padding: EdgeInsets.only(right: Defaults.defaultfontsize),
                  child: Column(
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: EdgeInsets.only(
                                  left: Defaults.defaultfontsize / 5,
                                  top: Defaults.defaultfontsize / 2),
                              child: Icon(
                                Icons.circle,
                                color: Colors.black,
                                size: 10,
                              ),
                            ),
                            SizedBox(width: 6),
                            Expanded(
                                child: Text(
                              e,
                              textAlign: TextAlign.left,
                            ))
                          ]),
                      SizedBox(height: Defaults.defaultfontsize),
                    ],
                  ),
                ),
              )
              .toList(),
        )
      ]),
    );
  }
}
