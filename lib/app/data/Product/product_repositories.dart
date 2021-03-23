import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/product_provider.dart';

class ProductRepositories implements ProductRepo {
  @override
  Future<Either<String, List<Product>>> fetchProduct(
      List<String> productId) async {
    List<Product> product = [];
    try {
      for (var id in productId) {
        await FirebaseFirestore.instance
            .collection("Product")
            .where('productId', isEqualTo: id)
            .get()
            .then((value) {
          // value.docs.map((e) => Product.fromMap())

          value.docs.forEach((newproduct) {
            product.add(Product(
              backgroundColor:
                  newproduct['backgroundColor']?.toString() ?? '#FFFFFF',
              productCuttedPrice: newproduct['productCuttedPrice'].toDouble(),
              productDescription: List.from(newproduct['productDescription']),
              productDiscount: newproduct['productDiscount'].toDouble(),
              productDiscountType: newproduct['productDiscountType'].toString(),
              productId: id,
              productImages: List.from(newproduct['productImages']),
              productName: newproduct['productName'].toString(),
              productOnDiscount: newproduct['productOnDiscount'] as bool,
              productOnSale: newproduct['productOnSale'] as bool,
              productPrice: newproduct['productPrice'].toDouble(),
              productStock: newproduct['productStock'] as bool,
            ));
          });
        });
      }

      return right(product);
    } catch (error) {
      return left('Error on Fetching Product');
    }
  }
}
