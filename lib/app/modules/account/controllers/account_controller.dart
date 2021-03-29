import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:rasan_mart/app/modules/authentication/views/authentication_view.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/home/views/home_view.dart';
import 'package:rasan_mart/app/modules/splash/views/splash_view.dart';

class AccountController extends GetxController {
  RxList<AddressModel> addressList;
  RxString userName = 'Profile Name'.obs;
  RxString userEmail = 'Email Address'.obs;
  RxString userPhone = 'User phone No'.obs;
  final _auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser;
  RxString userImage = 'assets/images/logo.PNG'.obs;
  RxString uId = ''.obs;

  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserInfo();
  }

  void fetchUserInfo() {
    if (user != null) {
      user.providerData.forEach((profile) {
        if (profile.displayName != null) userName.value = profile.displayName;

        userEmail.value = profile.email;
        uId.value = profile.uid;
        if (profile.phoneNumber != null) userPhone.value = profile.phoneNumber;
        if (profile.photoURL != null) userImage.value = profile.photoURL;
      });
    }
  }

  void LogOut() {
    FirebaseAuth.instance.signOut();

    // Get.offAll(() => HomeView());
    clearData();
  }

  void clearData() {
    Get.find<CartController>().cartList.clear();
    userEmail.value = 'User Email';

    userPhone.value = 'User Phone Number';
    userImage.value = 'assets/images/logo.PNG';
  }

  void UpdateUserInfo(String name, String url) {
    user.updateProfile(displayName: name, photoURL: url).then((value) => null);
    userName.value = name;
    userImage.value = url;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
