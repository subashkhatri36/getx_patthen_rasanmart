import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rasan_mart/app/data/local_data/dummy_data.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';

abstract class ProductContianerRepo {
  Future<Either<String, List<ProductContianer>>> fetchOnlineProductContianer(
      {@required String category});
  List<ProductContianer> fetchOfflineProductContianer();
}

class ProductContianerRepositories implements ProductContianerRepo {
  @override
  List<ProductContianer> fetchOfflineProductContianer() {
    print('Returning offline values');
    return productContainerdata;
  }

  @override
  Future<Either<String, List<ProductContianer>>> fetchOnlineProductContianer(
      {String category}) async {
    List<ProductContianer> container = [];
    try {
      await FirebaseFirestore.instance
          .collection('Categories')
          .doc(category)
          .collection('data')
          .orderBy("layoutindex", descending: false)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          int layouttype = element['layoutType'] as int;

          if (layouttype == 3 || layouttype == 4) {
            container.add(ProductContianer(
              layoutindex: element['layoutindex'] as int,
              layoutType: element['layoutType'] as int,
              backgroundColor: element['backgroundColor'].toString().isEmpty
                  ? Colors.transparent
                  : HexColor(
                      element['backgroundColor'].toString(),
                    ),
              containerTitle: element['containerTitle']?.toString(),
              productIdList: List.from(element['productIdList']),
            ));
          } else {
            container.add(ProductContianer(
              layoutindex: element['layoutindex'] as int,
              layoutType: element['layoutType'] as int,
              backgroundColor: element['backgroundColor'].toString().isEmpty
                  ? Colors.transparent
                  : HexColor(
                      element['backgroundColor'].toString(),
                    ),
              containerTitle: element['containerTitle']?.toString(),
              productIdList: [],
            ));
          }
          //print(ProductContianer.length);
        });
      });

      return right(container);
    } catch (e) {
      return left('container');
    }
  }
}
