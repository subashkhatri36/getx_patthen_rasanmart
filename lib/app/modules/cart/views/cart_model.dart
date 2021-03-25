import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

class CartModel {
  final Product product;
  final String cartId;
  CartModel({
    @required this.product,
    this.cartId,
  });

  Map<String, dynamic> toMap() {
    return {
      'product': product.toMap(),
      'cartId': cartId,
    };
  }

  factory CartModel.fromMap(Map<String, dynamic> map) {
    return CartModel(
      product: Product.fromMap(map['product']),
      cartId: map['cartId'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CartModel.fromJson(String source) =>
      CartModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartModel &&
        other.product == product &&
        other.cartId == cartId;
  }

  @override
  int get hashCode => product.hashCode ^ cartId.hashCode;
}
