import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rasan_mart/app/data/local_data/get_storage.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartRepository implements CartProvider {
  LocalDB localDB = new LocalDB();
  @override
  Future<Either<String, String>> addCart(
      {@required Product product, String data}) async {
    if (data == null) data = localDB.readToDB();

    String msg = 'No data';
    try {
      await FirebaseFirestore.instance
          .collection(data)
          .add(product.toMap())
          .whenComplete(() => msg = 'Successfully Added to Cart');

      return right(msg);
    } catch (error) {
      print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<Product>>> fetchCart(String data) async {
    if (data == null) data = localDB.readToDB();
    List<Product> _product = [];
    print('Database' + data.toString());
    try {
      await FirebaseFirestore.instance.collection(data).get().then((value) {
        value.docs.forEach((element) {
          _product.add(Product(
            productId: element.id,
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
            similarproduct: List.from(element['similarproduct']),
          ));
        });
      });
      // print(_product);

      return right(_product);
    } catch (error) {
      print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteCartItems({String cartId, String data}) {
    // TODO: implement deleteCartItems
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> removeCart({String productId, String data}) {
    // TODO: implement removeCart
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateCart({String productId, String data}) {
    // TODO: implement updateCart
    throw UnimplementedError();
  }
}
