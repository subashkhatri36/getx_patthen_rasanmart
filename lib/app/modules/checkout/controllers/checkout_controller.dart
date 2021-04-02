import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/data/checkout/checkout_repository.dart';
import 'package:rasan_mart/app/modules/authentication/controllers/mainauth_controller.dart';
import 'package:rasan_mart/app/modules/cart/controllers/cart_controller.dart';
import 'package:rasan_mart/app/modules/checkout/providers/checkout_provider.dart';

class CheckoutController extends GetxController {
  //TODO: Implement CheckoutController

  final count = 0.obs;
  RxBool paymentMode = false.obs;
  RxBool addressSelected = false.obs;
  RxInt paymentSelectedMode = 0.obs;
  List<String> paymentModeImage = [
    'assets/images/cod.jpeg',
    'assets/images/khalti.png',
    'assets/images/imepay.jpg',
    'assets/images/esewa.png',
    'assets/images/paypal.png',
    'assets/images/visamaster.png'
  ];

  final auth = Get.find<MainauthController>().firebaseAuth;
  final cartController = Get.find<CartController>();
  CheckoutProvider checkoutProvider = CheckoutRepository();

  @override
  void onInit() {
    super.onInit();
  }

  void checkoutAuthenticationCheck() async {
    if (auth.currentUser != null) {
      //userLogged In and process to delivery cart.
      //delivery charge
      var id = auth.currentUser?.uid ?? '';
      if (id.isNotEmpty && id != null) {
        Either<String, String> savetodeliver =
            await checkoutProvider.saveToDelivery(id, cartController.cartList);
        savetodeliver.fold(
          (l) => print('Error'),
          (r) => print('Delivery Conformed!'),
        );
      }
    } else {
      //show dialog to continue with offline or sign in.

    }
  }

  Future<Either<String, String>> savedToDelivery() {}

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
