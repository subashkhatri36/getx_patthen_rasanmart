import 'package:get/get.dart';

class ProductcontainerproviderProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
}
