import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import 'package:rasan_mart/app/modules/account/address_model.dart';

class UserDetail {
  final String userName;
  final String userEmail;
  final String photo;
  final String phone;
  UserDetail({
    @required this.userName,
    @required this.userEmail,
    @required this.photo,
    @required this.phone,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserDetail &&
        other.userName == userName &&
        other.userEmail == userEmail &&
        other.photo == photo &&
        other.phone == phone;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        userEmail.hashCode ^
        photo.hashCode ^
        phone.hashCode;
  }
}

abstract class UserdataProvider {
  Future<Either<String, String>> uploadImage(File path, String userId);
  Future<Either<String, List<AddressModel>>> fetchAddress(String userId);
  Future<Either<String, AddressModel>> savedAddress(
      AddressModel address, String userId);
  Future<Either<String, UserDetail>> fetchUserData(String userId);
  Future<Either<String, String>> saveandUpdateUserData(
      UserDetail userDetail, String userId);
  Future<Either<String, String>> updateUserData(
      UserDetail userDetail, String userId);
  Future<Either<String, String>> insertUserAddress(
      AddressModel address, String userId);
  Future<Either<String, List<AddressModel>>> getUserAddress(String userId);
  Future<Either<String, String>> updateUserAddress(
      AddressModel address, String userId, String docId);
}
