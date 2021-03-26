import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/data/local_data/get_storage.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/cart_provider.dart';

class CartRepository implements CartProvider {
  LocalDB localDB = new LocalDB();

  @override
  Future<Either<String, String>> addCart(
      {@required Product product, String data}) async {
    if (data == null) data = localDB.readToDB();

    //Product _product = product.product;

    String msg = '';
    try {
      await FirebaseFirestore.instance
          .collection(data)
          .add(product.toMap())
          .then((value) {
        msg = value.id;
      });

      return right(msg);
    } catch (error) {
      // print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, List<CartModel>>> fetchCart(String data) async {
    if (data == null) data = localDB.readToDB();

    List<CartModel> _product = [];
    //print('Database' + data.toString());
    try {
      await FirebaseFirestore.instance.collection(data).get().then((value) {
        value.docs.forEach((element) {
          _product.add(CartModel(
              product: Product(
                productId: element['productId'],
                productName: element['productName'].toString(),
                productImages: List.from(element['productImages']),
                productDescription: List.from(element['productDescription']),
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
                tags: List.from(element['tags']),
              ),
              cartId: element.id));
          // print(element.id);
        });
      });

      return right(_product);
    } catch (error) {
      //  print(error);
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteCartItems(
      {String cartId, String data}) async {
    if (data == null) data = localDB.readToDB();

    String msg = '';

    try {
      await FirebaseFirestore.instance
          .collection(data)
          .doc(cartId)
          .delete()
          .then((value) {
        msg = Strings.successMessage;
      });
      if (msg.contains(Strings.successMessage))
        return right(Strings.successMessage);
      else
        return left(Strings.FailedMessage);
    } catch (error) {
      return left('Handler: ' + Strings.FailedMessage);
    }
  }

  @override
  Future<Either<String, String>> removeCart({String productId, String data}) {
    // TODO: implement removeCart
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> updateCart(
      {CartModel cartModel, String data}) async {
    if (data == null) data = localDB.readToDB();

    Product _product = cartModel.product;
    String cartId = cartModel.cartId;

    String msg = 'No data';
    try {
      await FirebaseFirestore.instance
          .collection(data)
          .doc(cartId)
          .update(_product.toMap())
          .whenComplete(() => msg = 'Successfully Updated to Cart');

      return right(msg);
    } catch (error) {
      //print(error);
      return left(error.toString());
    }
  }
}
