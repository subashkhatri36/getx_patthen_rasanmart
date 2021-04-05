import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/delivery/delivery_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:rasan_mart/app/modules/checkout/providers/delivery_provider.dart';

class DeliveryController extends GetxController {
  RxList<DeliveryTotalModel> deliveryModel;
  RxBool isDeliveryLoaded = false.obs;
  final auth = Get.find<MainauthController>().firebaseAuth;
  DeliveryProvider providerdelivery = DeliveryRepository();

  @override
  void onInit() {
    super.onInit();
    fetchDeliveryModel();
  }

  void fetchDeliveryModel() async {
    List<DeliveryTotalModel> model = [];
    if (auth.currentUser != null) {
      var id = auth.currentUser.uid;
      if (id != null && id.isNotEmpty) {
        Either<String, List<DeliveryTotalModel>> getDelivery =
            await providerdelivery.fetchDeliveryOrder(id);
        getDelivery.fold((l) => print(l), (r) {
          model = r.toList();
          deliveryModel = model.obs;
        });
      }
    }
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
