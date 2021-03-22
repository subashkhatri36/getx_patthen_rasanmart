import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';

class SalesAndDiscount extends StatefulWidget {
  final bool isSaleType;
  final double discount;
  final String discountType;
  final bool isgridview;

  const SalesAndDiscount({
    Key key,
    @required this.isSaleType,
    @required this.discount,
    @required this.discountType,
    @required this.isgridview,
  }) : super(key: key);

  @override
  _SalesAndDiscountState createState() => _SalesAndDiscountState();
}

class _SalesAndDiscountState extends State<SalesAndDiscount>
    with TickerProviderStateMixin {
  AnimationController _controller;
  @override
  void initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed)
          _controller.reverse();
        else if (status == AnimationStatus.dismissed) _controller.forward();
      });
    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return Container(
            margin: widget.isSaleType
                ? EdgeInsets.zero
                : widget.isgridview
                    ? EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .28)
                    : EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .23),
            height: widget.isSaleType ? 35 : 35,
            width: 35,
            decoration: BoxDecoration(
                color: ColorTween(
                  begin: widget.isSaleType
                      ? Themes.lightSalesolor
                      : Theme.of(context).backgroundColor,
                  end: widget.isSaleType
                      ? Colors.greenAccent[100]
                      : Theme.of(context).backgroundColor,
                ).animate(_controller).value,
                borderRadius: BorderRadius.circular(Defaults.defaultPadding)),
            padding: widget.isSaleType
                ? EdgeInsets.all(Defaults.defaultfontsize - 6)
                : EdgeInsets.all(Defaults.defaultfontsize / 3),
            alignment: Alignment.center,
            child: Text(
              widget.isSaleType
                  ? 'Sale'
                  : discountString(
                      discountType: widget.discountType,
                      discountAmount: widget.discount.toString()),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: Defaults.defaultfontsize - 5),
            ),
          );
        });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
