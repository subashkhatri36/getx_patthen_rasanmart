import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/account/controllers/account_controller.dart';

class MainauthController extends GetxController {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance.obs();
  UserCredential userCredential = null.obs();
  RxString userId = ''.obs;
  

  @override
  void onInit() {


    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
