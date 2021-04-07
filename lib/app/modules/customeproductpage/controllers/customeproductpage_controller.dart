import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/Product/product_container_repositories.dart';
import 'package:rasan_mart/app/modules/customeproductpage/product_contianer_model.dart';

class CustomeproductpageController extends GetxController {
  RxString categories = 'Home'.toUpperCase().obs;
  RxList<ProductContianer> productContianerList;
  RxBool isProductContianerLioading = false.obs;

  RxInt index = 0.obs;
  RxInt productindex = 0.obs;
  RxInt gridIndex = 0.obs;

  ProductContianerRepo _productContainerRepo =
      new ProductContianerRepositories();

  @override
  void onInit() {
    loadproductContianer();
    super.onInit();
  }

  void loadproductContianer() async {
    isProductContianerLioading.toggle();
    Either<String, List<ProductContianer>> containerValue =
        await _productContainerRepo.fetchOnlineProductContianer(
            category: categories.value);
    containerValue.fold((l) {
      productContianerList =
          _productContainerRepo.fetchOfflineProductContianer().toList().obs;
    }, (r) => productContianerList = r.toList().obs);
    isProductContianerLioading.toggle();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void changeCategories(String category) =>
      categories.value = category.toUpperCase();

  void productincreaseindex() => productindex.value++;
  void gridincreaseindex() => gridIndex.value++;
}
