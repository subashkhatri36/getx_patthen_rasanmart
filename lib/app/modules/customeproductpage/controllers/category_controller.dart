import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/category/category_repository.dart';
import 'package:rasan_mart/app/modules/customeproductpage/categories_model.dart';

class CategoryController extends GetxController {
  RxList<Categories> categories;
  RxBool isCategoryLoading = false.obs;

  CategoryRepo repository = new CategoriesRepositories();
  @override
  void onInit() {
    super.onInit();
    fetchCategories();
  }

  fetchCategories() async {
    isCategoryLoading.toggle();
    Either<String, List<Categories>> catgories =
        await repository.getCategories();
    catgories.fold((l) => print(l.toString()), (r) {
      categories = r.toList().obs;
    });

    isCategoryLoading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
