import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';

class TotalProductPrice extends StatelessWidget {
  const TotalProductPrice({
    Key key,
    @required this.totalprice,
    @required this.isdetailpage,
  }) : super(key: key);

  final double totalprice;
  final bool isdetailpage;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Price (NRs.) ',
          style: TextStyle(
              fontSize: isdetailpage
                  ? Defaults.defaultfontsize * 1.5
                  : Defaults.defaultfontsize - 4,
              fontWeight: FontWeight.bold,
              color: Colors.black45),
        ),
        SizedBox(width: Defaults.defaultfontsize / 3),
        Text(
          totalprice.toString(),
          style: TextStyle(
              fontSize: isdetailpage
                  ? Defaults.defaultfontsize * 1.5
                  : Defaults.defaultfontsize - 4,
              fontWeight: FontWeight.bold,
              color: Colors.black45),
        ),
      ],
    );
  }
}
