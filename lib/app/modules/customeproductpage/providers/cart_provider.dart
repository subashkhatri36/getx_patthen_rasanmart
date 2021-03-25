import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';

import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

abstract class CartProvider {
  Future<Either<String, List<CartModel>>> fetchCart(String data);
  Future<Either<String, String>> addCart(
      {@required Product product, String data});
  Future<Either<String, String>> removeCart(
      {@required String productId, String data});
  Future<Either<String, String>> updateCart({
    @required CartModel cartModel,
    String data,
  });
  Future<Either<String, String>> deleteCartItems(
      {@required String cartId, String data});
}
