import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';

abstract class AddressProvider {
  Future<Either<String, String>> savedAddress(
      String userId, AddressModel addressModel);
  Future<Either<String, String>> updateAddress(
      String userId, AddressModel addressModel, String id);
  Future<Either<String, String>> updateSingleFieldAddress(
      String userId, bool value, String id);
  Future<Either<String, String>> deleteAddress(String userId, String id);
}
