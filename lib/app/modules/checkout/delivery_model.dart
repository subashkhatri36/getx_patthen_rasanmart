import 'dart:convert';

import 'package:flutter/foundation.dart';

class DeliveryModel {
  final String id;
  final String productId;
  final String productName;
  final int qty;
  final double rate;
  final double price;
  DeliveryModel({
    @required this.id,
    @required this.productId,
    @required this.productName,
    @required this.qty,
    @required this.rate,
    @required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'qty': qty,
      'rate': rate,
      'price': price,
    };
  }

  factory DeliveryModel.fromMap(Map<String, dynamic> map) {
    return DeliveryModel(
      id: map['id'],
      productId: map['productId'],
      productName: map['productName'],
      qty: map['qty'],
      rate: map['rate'],
      price: map['price'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryModel.fromJson(String source) =>
      DeliveryModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveryModel &&
        other.id == id &&
        other.productId == productId &&
        other.productName == productName &&
        other.qty == qty &&
        other.rate == rate &&
        other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        qty.hashCode ^
        rate.hashCode ^
        price.hashCode;
  }
}

class DeliveryTotalModel {
  final List<DeliveryModel> deliverymodel;
  final String id;
  final int totalproduct;
  final double totalprice;
  final double discount;
  final double grandtotal;
  DeliveryTotalModel({
    @required this.deliverymodel,
    @required this.id,
    @required this.totalproduct,
    @required this.totalprice,
    @required this.discount,
    @required this.grandtotal,
  });

  Map<String, dynamic> toMap() {
    return {
      'deliverymodel': deliverymodel?.map((x) => x.toMap())?.toList(),
      'id': id,
      'totalproduct': totalproduct,
      'totalprice': totalprice,
      'discount': discount,
      'grandtotal': grandtotal,
    };
  }

  factory DeliveryTotalModel.fromMap(Map<String, dynamic> map) {
    return DeliveryTotalModel(
      deliverymodel: List<DeliveryModel>.from(
          map['deliverymodel']?.map((x) => DeliveryModel.fromMap(x))),
      id: map['id'],
      totalproduct: map['totalproduct'],
      totalprice: map['totalprice'],
      discount: map['discount'],
      grandtotal: map['grandtotal'],
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryTotalModel.fromJson(String source) =>
      DeliveryTotalModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveryTotalModel &&
        listEquals(other.deliverymodel, deliverymodel) &&
        other.id == id &&
        other.totalproduct == totalproduct &&
        other.totalprice == totalprice &&
        other.discount == discount &&
        other.grandtotal == grandtotal;
  }

  @override
  int get hashCode {
    return deliverymodel.hashCode ^
        id.hashCode ^
        totalproduct.hashCode ^
        totalprice.hashCode ^
        discount.hashCode ^
        grandtotal.hashCode;
  }
}
