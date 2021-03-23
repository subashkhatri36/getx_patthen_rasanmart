import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/cart_and_quickview_btn.dart';
import 'package:rasan_mart/app/Widgets/Product/total_product_price.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

class QuantityAndTotalpriceContainer extends StatefulWidget {
  const QuantityAndTotalpriceContainer({
    Key key,
    @required this.product,
    @required this.isdetailpage,
  }) : super(key: key);

  final Product product;
  final bool isdetailpage;

  @override
  _QuantityContainerState createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityAndTotalpriceContainer> {
  Product _product;
  int qty = 1;
  double _totalprice = 0;
  @override
  void initState() {
    _product = widget.product;
    _product.setQty(1);
    _product.setPrice(_product.productPrice);
    _totalprice = _product.productPrice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: Defaults.defaultfontsize),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Qty',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isdetailpage
                        ? Defaults.defaultfontsize * 1.5
                        : Defaults.defaultfontsize - 2),
              ),
              SizedBox(width: Defaults.defaultfontsize / 2),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        countermethod(CounterType.Decreament);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Colors.black38,
                            style: BorderStyle.solid,
                          ),
                          color: widget.isdetailpage
                              ? Theme.of(context).backgroundColor
                              : Theme.of(context).accentColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40)),
                        ),
                        height: widget.isdetailpage
                            ? Defaults.defaultfontsize * 2
                            : Defaults.defaultfontsize + 2,
                        width: widget.isdetailpage
                            ? Defaults.defaultfontsize * 3
                            : Defaults.defaultfontsize * 1.5,
                        child: Icon(
                          Icons.remove,
                          color: widget.isdetailpage
                              ? Theme.of(context).primaryColor
                              : Colors.black54,
                          size: widget.isdetailpage
                              ? Defaults.defaultfontsize + 5
                              : Defaults.defaultfontsize,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                          right: widget.isdetailpage
                              ? Defaults.defaultPadding / 2
                              : Defaults.defaultPadding / 3,
                          left: widget.isdetailpage
                              ? Defaults.defaultPadding / 2
                              : Defaults.defaultPadding / 3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black38,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Text(
                        qty.toString(),
                        style: TextStyle(
                            fontSize: widget.isdetailpage
                                ? Defaults.defaultfontsize * 1.5
                                : Defaults.defaultfontsize - 2),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        countermethod(CounterType.Increament);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: Colors.black38,
                              style: BorderStyle.solid,
                            ),
                            color: widget.isdetailpage
                                ? Theme.of(context).backgroundColor
                                : Theme.of(context).accentColor,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(40),
                                bottomRight: Radius.circular(40))),
                        height: widget.isdetailpage
                            ? Defaults.defaultfontsize * 2
                            : Defaults.defaultfontsize + 2,
                        width: widget.isdetailpage
                            ? Defaults.defaultfontsize * 3
                            : Defaults.defaultfontsize * 1.5,
                        child: Icon(
                          Icons.add,
                          color: widget.isdetailpage
                              ? Theme.of(context).primaryColor
                              : Colors.black54,
                          size: widget.isdetailpage
                              ? Defaults.defaultfontsize + 5
                              : Defaults.defaultfontsize,
                        ),
                      ),
                    ),

                    //Now Price
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: Defaults.defaultfontsize),
          TotalProductPrice(
            totalprice: _totalprice,
            isdetailpage: widget.isdetailpage,
          ),
          SizedBox(height: Defaults.defaultfontsize),
          buildCartAndQuick(false, context, _product),
        ],
      ),
    );
  }

  bool counterIncrement(CounterType counterType) {
    switch (counterType) {
      case CounterType.Increament:
        return true;
        break;
      default:
        return false;
        break;
    }
  }

  void countermethod(CounterType counterType) {
    switch (counterType) {
      case CounterType.Increament:
        setState(() {
          qty++;
          _totalprice = _product.productPrice * qty;
          _totalprice = _totalprice.toPrecision(3);
          _product.setQty(qty);
          _product.setPrice(_totalprice);
        });
        break;
      case CounterType.Decreament:
        setState(() {
          if (qty > 1) {
            qty--;
            _totalprice = _product.productPrice * qty;
            _totalprice = _totalprice.toPrecision(3);
            _product.setQty(qty);
            _product.setPrice(_totalprice);
          } else {
            qty = 1;
            _totalprice = _product.productPrice * qty;
            _totalprice = _totalprice.toPrecision(3);
            _product.setQty(qty);
            _product.setPrice(_totalprice);
          }
        });
        break;
      default:
        setState(() {
          qty = 1;
          _totalprice = _product.productPrice * qty;
          _totalprice = _totalprice.toPrecision(3);
          _product.setQty(qty);
          _product.setPrice(_totalprice);
        });
        break;
    }
  }
}

extension Ex on double {
  double toPrecision(int n) => double.parse(toStringAsFixed(n));
}
