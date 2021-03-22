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
  final bool productStock;
  int qty;
  double price;

  Product({
    @required this.productStock,
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.productId == productId &&
        other.productName == productName &&
        listEquals(other.productImages, productImages) &&
        listEquals(other.productDescription, productDescription) &&
        other.productPrice == productPrice &&
        other.productCuttedPrice == productCuttedPrice &&
        other.productOnSale == productOnSale &&
        other.productDiscount == productDiscount &&
        other.productDiscountType == productDiscountType &&
        other.productOnDiscount == productOnDiscount &&
        other.backgroundColor == backgroundColor &&
        other.productStock == productStock &&
        other.qty == qty &&
        other.price == price;
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
        backgroundColor.hashCode ^
        productStock.hashCode ^
        qty.hashCode ^
        price.hashCode;
  }

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
      'productStock': productStock,
      'qty': qty,
      'price': price,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
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
      productStock: map['productStock'],
      qty: map['qty'] ?? 0,
      price: map['price'] ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
