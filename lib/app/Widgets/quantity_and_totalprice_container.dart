import 'package:flutter/material.dart';
import 'package:rasan_mart/app/Widgets/Product/cart_and_quickview_btn.dart';
import 'package:rasan_mart/app/Widgets/Product/total_product_price.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/enum/enums.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:get/get.dart';

class QuantityAndTotalpriceContainer extends StatefulWidget {
  const QuantityAndTotalpriceContainer({
    Key key,
    @required this.product,
    this.isdetailpage = false,
    this.isproducthorizental = false,
  }) : super(key: key);

  final Product product;
  final bool isdetailpage;
  final bool isproducthorizental;

  @override
  _QuantityContainerState createState() => _QuantityContainerState();
}

class _QuantityContainerState extends State<QuantityAndTotalpriceContainer> {
  final cartcontroller = Get.find<CartController>();
  Product _product;

  bool _horizentalproduct;

  @override
  void initState() {
    // setState(() {
    _horizentalproduct = widget.isproducthorizental;
    _product = widget.product;

    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: Defaults.defaultfontsize),
      child: Column(
        crossAxisAlignment: _horizentalproduct
            ? CrossAxisAlignment.start
            : CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: _horizentalproduct
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Text(
                'Qty',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: widget.isdetailpage
                        ? Defaults.defaultfontsize * 1.5
                        : _horizentalproduct
                            ? Defaults.defaultfontsize
                            : Defaults.defaultfontsize - 2),
              ),
              SizedBox(width: Defaults.defaultfontsize / 2),
              Container(
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        countermethod(
                            CounterType.Decreament, _horizentalproduct);
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
                      //
                      child: Text(
                        _product.qty.toString(),
                        style: TextStyle(
                            fontSize: widget.isdetailpage
                                ? Defaults.defaultfontsize * 1.5
                                : Defaults.defaultfontsize - 2),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        countermethod(
                            CounterType.Increament, _horizentalproduct);
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
            totalprice: _product.price,
            isdetailpage: widget.isdetailpage,
            ishorizentalproduct: _horizentalproduct,
          ),
          if (!widget.isdetailpage && !_horizentalproduct)
            SizedBox(height: Defaults.defaultfontsize),
          if (!widget.isdetailpage && !_horizentalproduct)
            buildCartAndQuick(false, context, _product, _horizentalproduct),
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

  void countermethod(CounterType counterType, bool iscart) {
    cartcontroller.cartUpdate.value = !cartcontroller.cartUpdate.value;
    switch (counterType) {
      case CounterType.Increament:
        setState(() {
          increment();
        });
        break;
      case CounterType.Decreament:
        setState(() {
          if (_product.qty > 1) {
            decrement();
          } else {
            defaultdata();
          }
        });
        break;
      default:
        setState(() {
          defaultdata();
        });
        break;
    }
  }

  void increment() {
    _product.qty++;
    _product.price = _product.productPrice * _product.qty;

    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    cartcontroller.calculateTotalsAmount();
  }

  void decrement() {
    _product.qty--;
    _product.price = _product.productPrice * _product.qty;

    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    cartcontroller.calculateTotalsAmount();
  }

  void defaultdata() {
    _product.qty = 1;
    _product.price = _product.productPrice * _product.qty;
    // _product.setQty(qty);
    // _product.setPrice(_totalprice);
    cartcontroller.calculateTotalsAmount();
  }
}
