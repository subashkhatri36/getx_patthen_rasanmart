import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_model.dart';

abstract class DeliveryProvider {
  Future<Either<String, List<DeliveryTotalModel>>> fetchDeliveryOrder(
      String userId);
  Future<Either<String, String>> cancelOrder(
      String userId, DeliveryTotalModel model, String docId);
}
