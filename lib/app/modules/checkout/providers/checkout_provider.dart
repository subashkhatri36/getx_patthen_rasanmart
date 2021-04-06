import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/cart/views/cart_model.dart';
import 'package:rasan_mart/app/modules/cart/views/product_total_model.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';

abstract class CheckoutProvider {
  Future<Either<String, DeliveryTotalModel>> saveToDelivery(
    String userId,
    List<CartModel> cartmodel,
    ProductPriceCalculation calculation,
    String paymentType,
    String paymentStatus,
    String address,
  );
  Future<Either<String, String>> deleteFromDelivery(
      String userId, String derliveryId);
  Future<Either<String, List<DeliveryTotalModel>>> fetchFromDelivery(
      String userId);
}
