import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

class AmountBox extends StatelessWidget {
  const AmountBox(
      {Key key, @required this.product, @required this.isdetailpage})
      : super(key: key);

  final Product product;
  final bool isdetailpage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment:
          isdetailpage ? MainAxisAlignment.start : MainAxisAlignment.center,
      children: [
        Text('NRs. ' + product.productPrice.toString(),
            style: TextStyle(
                color: Theme.of(context).backgroundColor,
                fontSize: isdetailpage
                    ? Defaults.defaultfontsize
                    : Defaults.defaultfontsize - 4,
                fontWeight: FontWeight.bold)),
        SizedBox(width: Defaults.defaultfontsize - 5),
        Text('NRs. ' + product.productCuttedPrice.toString(),
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context).accentColor,
                fontSize: isdetailpage
                    ? Defaults.defaultfontsize
                    : Defaults.defaultfontsize - 4,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
