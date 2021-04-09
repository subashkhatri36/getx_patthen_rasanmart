import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/checkout/coupen_model.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_price.dart';
import 'package:rasan_mart/app/modules/checkout/user_coupen.dart';

abstract class SettingRepository {
  Future<Either<String, UserCoupen>> fetchUserCoupen(String userId);
  Future<Either<String, Coupen>> fetchCoupen();
  Future<Either<String, DeliveryPrice>> fetchDeliveryPrice();
}
