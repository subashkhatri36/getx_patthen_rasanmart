import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

abstract class CartProvider {
  Future<Either<String, List<Product>>> fetchCart({var userData});
  Future<Either<String, String>> addCart({
    @required Product product,
  });
  Future<Either<String, String>> removeCart({
    @required String productId,
  });
  Future<Either<String, String>> updateCart({
    @required String productId,
  });
}
