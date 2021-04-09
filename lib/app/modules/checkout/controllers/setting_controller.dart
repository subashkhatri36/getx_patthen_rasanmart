import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/state_manager.dart';
import 'package:rasan_mart/app/data/settings/settings_repositories.dart';
import 'package:rasan_mart/app/modules/checkout/coupen_model.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_price.dart';
import 'package:rasan_mart/app/modules/checkout/providers/default_setting.dart';
import 'package:rasan_mart/app/modules/checkout/user_coupen.dart';

class SettingController extends GetxController {
  Coupen coupen;
  DeliveryPrice deliveryPrice;
  UserCoupen userCoupen;
  RxBool isLoadingSetting = false.obs;
  SettingRepository settingRepository = new SettingsRepositories();
  RxBool coupenContiainer = false.obs;
  RxBool showCoupen = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadSetting();
  }

  Future loadSetting() async {
    await getDeliveryPrice();
    await getCoupen();
    await getUserCoupen();
    isLoadingSetting.toggle();
  }

  getDeliveryPrice() async {
    Either<String, DeliveryPrice> deliveryprice =
        await settingRepository.fetchDeliveryPrice();
    deliveryprice.fold((l) => print(l), (r) {
      deliveryPrice = r;
    });
  }

  getCoupen() async {
    Either<String, Coupen> deliveryprice =
        await settingRepository.fetchCoupen();
    deliveryprice.fold((l) => print(l), (r) {
      coupen = r;
    });
  }

  getUserCoupen() async {
    var id = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (id.isNotEmpty) {
      Either<String, UserCoupen> deliveryprice =
          await settingRepository.fetchUserCoupen(id);
      deliveryprice.fold((l) => print(l), (r) {
        userCoupen = r;
      });
    } else {
      userCoupen = new UserCoupen(totalpurchase: 0, totalpurchaseCash: 0);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
