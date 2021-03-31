import 'package:get_storage/get_storage.dart';

class LocalDB {
  final box = GetStorage();

  void writeToDB(String data) {
    box.write('userId', data);
  }

  String readToDB() {
    return box.read('userId');
  }

  String removeFromDB() {
    box.remove('userId');
  }

  
}
