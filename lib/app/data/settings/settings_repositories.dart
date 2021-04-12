import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rasan_mart/app/modules/checkout/delivery_price.dart';
import 'package:rasan_mart/app/modules/checkout/coupen_model.dart';
import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/checkout/providers/default_setting.dart';
import 'package:rasan_mart/app/modules/checkout/user_coupen.dart';

class SettingsRepositories implements SettingRepository {
  @override
  Future<Either<String, Coupen>> fetchCoupen() async {
    try {
      bool complete = false;
      Coupen coupen;
      await FirebaseFirestore.instance
          .collection('settings')
          .doc('Coupen')
          .get()
          .then((value) {
        coupen = Coupen(
            coupenAmount: value['coupenAmount'].toDouble(),
            coupenType: value['coupenType'].toString(),
            coupenlimit: value['coupenlimit'].toDouble(),
            totalpurchase: value['totalpurchase'] as int);
      }).whenComplete(() => complete = true);

      if (complete)
        return right(coupen);
      else
        return left('Error ! some things went wrong in coupen');
    } catch (error) {
      return left('Error Occured while fetching Coupen setting');
    }
  }

  @override
  Future<Either<String, DeliveryPrice>> fetchDeliveryPrice() async {
    try {
      bool complete = false;
      DeliveryPrice deliveryPrice;
     await  FirebaseFirestore.instance
          .collection('settings')
          .doc('DeliveryPrice')
          .get()
          .then((value) {
        deliveryPrice = new DeliveryPrice(
            aboveDeliveryFree: value['aboveDeliveryFree'].toDouble(),
            deliveryAmount: value['deliveryAmount'].toDouble(),
            deliveryType: value['deliveryType'].toString(),
            freeDeliveryCity: List<String>.from(value['freeDeliveryCity']), maxDelivery: value['maxDelivery'].toDouble());
      }).whenComplete(() => complete = true);
      if (complete)
        return right(deliveryPrice);
      else
        return left('Error ! some things went wrong in delivery');
    } catch (error) {
      return left('Error Occured while fetching Delivery price setting');
    }
  }

  @override
  Future<Either<String, UserCoupen>> fetchUserCoupen(String userId) async {
    try {
      bool complete = false;
      UserCoupen coupen;
      await FirebaseFirestore.instance
          .collection('User')
          .doc(userId)
          .collection('coupen')
          .doc('coupenId')
          .get()
          .then((value) {
        coupen = new UserCoupen(
            totalpurchase: value['totalpurchase'] as int,
            totalpurchaseCash: value['totalpurchaseCash'].toDouble());
      }).whenComplete(() => complete = true);
      if (complete)
        return right(coupen);
      else
        return left('Error ! some things went wrong in usercoupen');
    } catch (error) {
      return left('Error Occured while fetching user Coupen setting');
    }
  }
}
