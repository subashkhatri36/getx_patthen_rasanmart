import 'package:get/get.dart';

import '../controllers/searchpage_controller.dart';

class SearchpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SearchpageController>(
      () => SearchpageController(),
    );
  }
}
