import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/searchpage/providers/searchpage_provider.dart';

class SearchRepository implements SearchpageProvider {
  @override
  Future<Either<String, List<Product>>> fetchingProductWithTags(
      String text) async {
    List<Product> searchlist = [];
    List result = text.split(' ');

    try {
      await FirebaseFirestore.instance
          .collection('Product')
          .where('tags', arrayContainsAny: result.toList())
          .get()
          .then((value) {
        value.docs.forEach((element) {
          searchlist.add(Product(
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
            qty: 1,
            price: element['productPrice'].toDouble(),
            similarproduct: List.from(element['similarproduct']),
            tags: List.from(element['tags']),
          ));
        });
      });

      return right(searchlist);
    } catch (error) {
      print(error);
      return left('Error While Searching');
    }
  }
}
