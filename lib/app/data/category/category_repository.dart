import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/customeproductpage/categories_model.dart';

abstract class CategoryRepo {
  Future<Either<String, List<Categories>>> getCategories();
}

class CategoriesRepositories implements CategoryRepo {
  @override
  Future<Either<String, List<Categories>>> getCategories() async {
    try {
      List<Categories> container = [];
      await FirebaseFirestore.instance
          .collection('Categories')
          .orderBy("index", descending: false)
          .get()
          .then((value) {
        value.docs.forEach((element) {
          //print(element['imagelink'].toString());
          if (element['active'] as bool) {
            container.add(Categories(
              categoryName: element['name'].toString(),
              categoryPath: element['imagelink'].toString(),
            ));
          }
        });
      });

      return right(container);
    } catch (error) {
      return left(error.toString());
    }
  }
}
