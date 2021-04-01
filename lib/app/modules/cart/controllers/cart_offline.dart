import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/data/local_data/cart_storage.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_model.dart';

class CartOffline {
  CartLocalDB cartoffline = CartLocalDB();

  Future<Either<String, List<CartModel>>> loadCartOffline() async {
    try {
      String jsondata = await cartoffline.readToDB();

      if (jsondata != null) {
        var cartValue = json.decode(await cartoffline.readToDB());
        List<CartModel> _product = [];
        cartValue.forEach((element) {
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
        return right(_product);
      } else {
        return left('No Data Found');
      }
    } catch (error) {
      return left('Error Occured During fetching');
    }
  }

  Future<Either<String, String>> addCartOffline(CartModel model) async {
    Either<String, List<CartModel>> getdata = await loadCartOffline();
    if (getdata != null) {
      cartoffline.writeToDB(model.toString());
    
      right('success');
    } else {
      getdata.fold((l) => left('Error on saving.'), (r) {
        r.add(model);
        cartoffline.writeToDB(r.toString());
        right('successful');
      });
    }
  }

  Future<Either<String, String>> deleteCartOffline(CartModel model) async {
    Either<String, List<CartModel>> getdata = await loadCartOffline();
    getdata.fold((l) => null, (r) {
      r.remove(model);
      cartoffline.writeToDB(r.toString());
    });
  }

  Future<Either<String, List<CartModel>>> updateCartOffline(
      CartModel model) async {
    Either<String, List<CartModel>> getdata = await loadCartOffline();
    getdata.fold((l) => null, (r) {
      List<CartModel> newModel = [];
      r.asMap().forEach((key, value) {
        if (r[key].cartId == model.cartId) r.removeAt(key);
      });
      r.add((model));
      cartoffline.writeToDB(r.toString());
    });
  }
}
