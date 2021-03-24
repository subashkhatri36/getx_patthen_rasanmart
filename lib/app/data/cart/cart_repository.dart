import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rasan_mart/app/data/local_data/get_storage.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartRepository implements CartProvider {
  LocalDB localDB = new LocalDB();

  @override
  Future<Either<String, String>> addCart({@required Product product}) async {
    String msg = 'No data';
    try {
      await FirebaseFirestore.instance
          .collection(localDB.readToDB())
          .add(product.toMap())
          .whenComplete(() => msg = 'Successfully Added to Cart');

      return right(msg);
    } catch (error) {
      print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> fetchCart() async {
    List<Product> _product = [];
    try {
      await FirebaseFirestore.instance
          .collection(localDB.readToDB())
          .get()
          .then((value) {
        value.docs.forEach((element) {
          print(localDB.readToDB());
          print(element['productName']);
          _product.add(Product(
            productId: element['productId'].toString(),
            productName: element['productName'].toString(),
            productImages: List.from(['productImages']),
            productDescription: List.from(['productDescription']),
            productPrice: element['productPrice'].toDouble(),
            productCuttedPrice: element['productCuttedPrice'].toDouble(),
            productOnSale: element['productOnSale'] as bool,
            productDiscount: element['productDiscount'].toDouble(),
            productDiscountType: element['productDiscountType'].toString(),
            productOnDiscount: element['productOnDiscount'] as bool,
            backgroundColor: element['backgroundColor'].toString(),
            productStock: element['productStock'] as bool,
            qty: element['qty'] as int,
            price: element['price'].toDouble(),
          ));
        });
      });
      print(_product.toList());

      return right(_product);
    } catch (error) {
      print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> removeCart(
      {@required String productId, var userData}) {
    // TODO: implement removeCart
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateCart(
      {@required String productId, var userData}) {
    // TODO: implement updateCart
    throw UnimplementedError();
  }
}
