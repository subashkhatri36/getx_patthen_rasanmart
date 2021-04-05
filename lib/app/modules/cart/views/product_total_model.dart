import 'package:flutter/foundation.dart';

class ProductPriceCalculation {
  final int totalItems;
  final int totaldiscount;
  final double totalprice;
  final double totaldiscountprice;
  final double deliverycharge;
  final double coupen;
  final double grandTotal;
  ProductPriceCalculation({
    @required this.deliverycharge,
    @required this.coupen,
    @required this.totalItems,
    @required this.totaldiscount,
    @required this.totalprice,
    @required this.totaldiscountprice,
    @required this.grandTotal,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductPriceCalculation &&
        other.totalItems == totalItems &&
        other.totaldiscount == totaldiscount &&
        other.totalprice == totalprice &&
        other.totaldiscountprice == totaldiscountprice &&
        other.deliverycharge == deliverycharge &&
        other.coupen == coupen &&
        other.grandTotal == grandTotal;
  }

  @override
  int get hashCode {
    return totalItems.hashCode ^
        totaldiscount.hashCode ^
        totalprice.hashCode ^
        totaldiscountprice.hashCode ^
        deliverycharge.hashCode ^
        coupen.hashCode ^
        grandTotal.hashCode;
  }
}
