import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasan_mart/app/modules/account/address_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/addAddress/providers/address_provider.dart';

class AddressRepository implements AddressProvider {
  @override
  Future<Either<String, String>> savedAddress(
      String userId, AddressModel addressModel) async {
    String message = 'Failed';
    try {
      Map<String, dynamic> map = {
        'place': addressModel.place,
        'tol': addressModel.tol,
        'city': addressModel.city,
        'muncipalit': addressModel.muncipalit,
        'state': addressModel.state,
        'zipcode': addressModel.zipcode,
        'phoneno': addressModel.phoneno,
        'landmark': addressModel.landmark,
        'isSelected': addressModel.isSelected,
      };
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .add(map)
          .then((value) {
        message = value.id;
      });
      return right(message);
    } catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<String, String>> updateAddress(
      String userId, AddressModel addressModel, String id) async {
    String message = 'Failed';
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .doc(id)
          .update(addressModel.toMap())
          .then((value) {
        message = 'Success';
      });
      return right(message);
    } catch (error) {
      return left(error);
    }
  }

  @override
  Future<Either<String, String>> updateSingleFieldAddress(
      String userId, bool value, String id) async {
    String message = 'Failed';
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .doc(id)
          .update({'isSelected': value}).then((value) {
        message = 'Success';
      });
      return right(message);
    } catch (error) {
      return left(error.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAddress(String userId, String id) async {
    String message = 'Failed';
    try {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('address')
          .doc(id)
          .delete()
          .then((value) {
        message = 'Success';
      });
      return right(message);
    } catch (error) {
      return left(error);
    }
  }
}
