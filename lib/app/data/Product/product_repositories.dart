import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/providers/product_provider.dart';

class ProductRepositories implements ProductRepo {
  @override
  Future<Either<String, List<Product>>> fetchProduct(
      List<String> productId) async {
    List<Product> product = [];

    for (var id in productId) {
      await FirebaseFirestore.instance
          .collection("Product")
          .where('productId', isEqualTo: id)
          .get()
          .then((value) {
        value.docs.forEach((newproduct) {
          print(newproduct['backgroundColor']);

          // print(newproduct['productDescription']);
          // print(newproduct['productId']);
          // print(newproduct['productImages']);
          //  print(newproduct['productName']);
          //print(newproduct['productOnDiscount']);
          //print(newproduct['productOnSale']);
          //print(newproduct['productPrice']);
          // print(newproduct['productStock']);

          print((newproduct['productCuttedPrice'] as int).toDouble());
          print((newproduct['productDiscount'] as int).toDouble());
          print((newproduct['productPrice'] as int).toDouble());
          // print(  (newproduct['productCuttedPrice'] as int).toDouble());
          //   print(  (newproduct['productCuttedPrice'] as int).toDouble());

          if (newproduct != null)
            product.add(Product(
              backgroundColor:
                  newproduct['backgroundColor']?.toString() ?? '#FFFFFF',
              productCuttedPrice:
                  (newproduct['productCuttedPrice'] as int).toDouble() ?? 22.0,
              productDescription: List.from(['productDescription']) ?? 'seef',
              productDiscount:
                  (newproduct['productDiscount'] as int).toDouble() ?? 222.2,
              productDiscountType:
                  newproduct['productDiscountType'].toString() ?? 'sefksd',
              productId: id,
              productImages: List.from(newproduct['productImages']) ?? '',
              productName: newproduct['productName'].toString() ?? '',
              productOnDiscount: newproduct['productOnDiscount'] as bool,
              productOnSale: newproduct['productOnSale'] as bool,
              productPrice: (newproduct['productPrice'] as int).toDouble(),
              productStock: newproduct['productStock'] as bool,
            ));
        });
      });
    }

/*
    productId.forEach((id) async {
      await FirebaseFirestore.instance
          .collection("Product")
          .where('productId', isEqualTo: id)
          .get()
          .then((value) {
        value.docs.forEach((newproduct) {
          print(newproduct);
          if (newproduct != null)
            product.add(Product(
              backgroundColor: newproduct['backgroundColor'].toString().isEmpty
                  ? '#FFFFFF'
                  : newproduct['backgroundColor'].toString(),
              productCuttedPrice:
                  (newproduct['productCuttedPrice'] as int).toDouble(),
              productDescription: List.from(['productDescription']),
              productDiscount:
                  (newproduct['productDiscount'] as int).toDouble(),
              productDiscountType: newproduct['productDiscountType'].toString(),
              productId: newproduct['productId'].toString(),
              productImages: List.from(newproduct['productImages']),
              productName: newproduct['productName'].toString(),
              productOnDiscount: newproduct['productOnDiscount'] as bool,
              productOnSale: newproduct['productOnSale'] as bool,
              productPrice: (newproduct['productPrice'] as int).toDouble(),
              productStock: newproduct['productStock'] as bool,
            ));
        });
      });
    });*/
    return right(product);
    // } catch (error) {
    //   return left('Error on Fetching Product');
    // }
  }
}
