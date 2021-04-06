import 'dart:convert';

import 'package:flutter/foundation.dart';

class DeliveryModel {
  final String id;
  final String productId;
  final String productName;
  final int qty;
  final double rate;
  final double price;
  final String image;

  DeliveryModel({
    @required this.id,
    @required this.productId,
    @required this.productName,
    @required this.qty,
    @required this.rate,
    @required this.price,
    @required this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'productId': productId,
      'productName': productName,
      'qty': qty,
      'rate': rate,
      'price': price,
      'image': image,
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
      image: map['image'],
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
        other.price == price &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        productName.hashCode ^
        qty.hashCode ^
        rate.hashCode ^
        price.hashCode ^
        image.hashCode;
  }
}

class DeliveryTotalModel {
  final List<DeliveryModel> deliverymodel;
  final String id;
  final int totalproduct;
  final double totalprice;
  final double discount;
  final double grandtotal;
  final double deliveryCharge;
  final String paymentMode;
  final String paymentStatus;
  final String orderStatus;
  final String orderData;
  final String shippingDate;
  final String deliveryDate;
  final double coupen;
  final String deliveryaddress;

  DeliveryTotalModel({
    @required this.deliverymodel,
    @required this.id,
    @required this.totalproduct,
    @required this.totalprice,
    @required this.discount,
    @required this.grandtotal,
    @required this.deliveryCharge,
    this.paymentStatus,
    this.paymentMode = 'Cash On Delivery',
    this.orderStatus = 'Order',
    this.orderData,
    this.shippingDate,
    this.deliveryDate,
    this.coupen = 0,
    @required this.deliveryaddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'deliverymodel': deliverymodel?.map((x) => x.toMap())?.toList(),
      'id': id,
      'totalproduct': totalproduct,
      'totalprice': totalprice,
      'discount': discount,
      'grandtotal': grandtotal,
      'deliveryCharge': deliveryCharge,
      'paymentMode': paymentMode,
      'orderStatus': orderStatus,
      'orderData': orderData,
      'shippingDate': shippingDate,
      'deliveryDate': deliveryDate,
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
      deliveryCharge: map['deliveryCharge'],
      paymentMode: map['paymentMode'],
      orderStatus: map['orderStatus'],
      orderData: map['orderData'],
      shippingDate: map['shippingDate'],
      deliveryDate: map['deliveryDate'],
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
        other.grandtotal == grandtotal &&
        other.deliveryCharge == deliveryCharge &&
        other.paymentMode == paymentMode &&
        other.orderStatus == orderStatus &&
        other.orderData == orderData &&
        other.shippingDate == shippingDate &&
        other.deliveryDate == deliveryDate;
  }

  @override
  int get hashCode {
    return deliverymodel.hashCode ^
        id.hashCode ^
        totalproduct.hashCode ^
        totalprice.hashCode ^
        discount.hashCode ^
        grandtotal.hashCode ^
        deliveryCharge.hashCode ^
        paymentMode.hashCode ^
        orderStatus.hashCode ^
        orderData.hashCode ^
        shippingDate.hashCode ^
        deliveryDate.hashCode;
  }
}
