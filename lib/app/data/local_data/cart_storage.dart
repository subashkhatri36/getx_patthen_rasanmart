import 'package:get_storage/get_storage.dart';

class CartLocalDB {
  final box = GetStorage('MyCart');

  void writeToDB(String data) {
    box.write('CartData', data);
  }

  Future<String> readToDB() async {
    return await box.read('CartData');
  }

  void removeFromDB() {
    box.remove('CartData');
  }
}
