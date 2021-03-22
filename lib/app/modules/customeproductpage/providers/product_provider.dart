import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

abstract class ProductRepo {
  Future<Either<String, List<Product>>> fetchProduct(List<String> productId);
}
