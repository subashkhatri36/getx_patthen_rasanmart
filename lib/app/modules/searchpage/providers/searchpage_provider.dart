import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

abstract class SearchpageProvider {
  Future<Either<String, List<Product>>> fetchingProductWithTags(String text);
}
