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
  Future<Either<String, List<Product>>> fetchCart({var userData}) {
    // TODO: implement fetchCart
    throw UnimplementedError();
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
