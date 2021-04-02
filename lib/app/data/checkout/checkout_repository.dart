import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/checkout/providers/checkout_provider.dart';

class CheckoutRepository implements CheckoutProvider {
  @override
  Future<Either<String, String>> deleteFromDelivery(
      String userId, String derliveryId) {
    // TODO: implement deleteFromDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<String, List<DeliveryTotalModel>>> fetchFromDelivery(
      String userId) {
    // TODO: implement fetchFromDelivery
    throw UnimplementedError();
  }

  @override
  Future<Either<String, String>> saveToDelivery(
      String userId, List<CartModel> model) {
    // TODO: implement saveToDelivery
    throw UnimplementedError();
  }
}
