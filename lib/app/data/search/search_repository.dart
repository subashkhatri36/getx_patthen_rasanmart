import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/searchpage/providers/searchpage_provider.dart';

class SearchRepository implements SearchpageProvider {
  @override
  Future<Either<String, List<Product>>> fetchingProductWithTags(
      String text) async {
    List<Product> searchlist;
    try {
      await FirebaseFirestore.instance
          .collection('Product')
          .where('tags', arrayContains: text)
          .snapshots()
          .forEach((value) {
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
            qty: element['qty'] as int,
            price: element['price'].toDouble(),
            similarproduct: List.from(element['similarproduct']),
            tags: List.from(element['tags']),
          ));
        });
      });
      // searchlist =
      //     value.docs.map<Product>((e) => Product.fromMap(e.data())).toList();

      print(searchlist);

      return right(searchlist);
    } catch (error) {
      return left('Error While Searching');
    }
  }
}
