import 'dart:convert';

import 'package:flutter/foundation.dart';

class Product {
  final String productId;
  final String productName;
  final List<String> productImages;
  final List<String> productDescription;
  final double productPrice;
  final double productCuttedPrice;
  final bool productOnSale;
  final double productDiscount;
  final String productDiscountType;
  final bool productOnDiscount;
  final String backgroundColor;
  int qty;
  double price;

  Product({
    @required this.productId,
    @required this.productOnDiscount,
    @required this.productImages,
    @required this.productDescription,
    @required this.productPrice,
    @required this.productCuttedPrice,
    @required this.productOnSale,
    @required this.productDiscount,
    @required this.productDiscountType,
    @required this.productName,
    @required this.backgroundColor,
    int qty,
    double price,
  });

  //getter abd setter
  int get qetQty => this.qty;
  setQty(int qty) => this.qty = qty;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productName': productName,
      'productImages': productImages,
      'productDescription': productDescription,
      'productPrice': productPrice,
      'productCuttedPrice': productCuttedPrice,
      'productOnSale': productOnSale,
      'productDiscount': productDiscount,
      'productDiscountType': productDiscountType,
      'productOnDiscount': productOnDiscount,
      'backgroundColor': backgroundColor,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Product(
      productId: map['productId'],
      productName: map['productName'],
      productImages: List<String>.from(map['productImages']),
      productDescription: List<String>.from(map['productDescription']),
      productPrice: map['productPrice'],
      productCuttedPrice: map['productCuttedPrice'],
      productOnSale: map['productOnSale'],
      productDiscount: map['productDiscount'],
      productDiscountType: map['productDiscountType'],
      productOnDiscount: map['productOnDiscount'],
      backgroundColor: map['backgroundColor'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Product &&
        o.productId == productId &&
        o.productName == productName &&
        listEquals(o.productImages, productImages) &&
        listEquals(o.productDescription, productDescription) &&
        o.productPrice == productPrice &&
        o.productCuttedPrice == productCuttedPrice &&
        o.productOnSale == productOnSale &&
        o.productDiscount == productDiscount &&
        o.productDiscountType == productDiscountType &&
        o.productOnDiscount == productOnDiscount &&
        o.backgroundColor == backgroundColor;
  }

  @override
  int get hashCode {
    return productId.hashCode ^
        productName.hashCode ^
        productImages.hashCode ^
        productDescription.hashCode ^
        productPrice.hashCode ^
        productCuttedPrice.hashCode ^
        productOnSale.hashCode ^
        productDiscount.hashCode ^
        productDiscountType.hashCode ^
        productOnDiscount.hashCode ^
        backgroundColor.hashCode;
  }

  @override
  String toString() {
    return 'Product(productId: $productId, productName: $productName, productImages: $productImages, productDescription: $productDescription, productPrice: $productPrice, productCuttedPrice: $productCuttedPrice, productOnSale: $productOnSale, productDiscount: $productDiscount, productDiscountType: $productDiscountType, productOnDiscount: $productOnDiscount, backgroundColor: $backgroundColor)';
  }
}
