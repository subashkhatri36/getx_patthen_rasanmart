import 'dart:convert';

import 'package:flutter/foundation.dart';

class DeliveryPrice {
  final double aboveDeliveryFree;
  final double deliveryAmount;
  final String deliveryType;
  final List<String> freeDeliveryCity;
  DeliveryPrice({
    @required this.aboveDeliveryFree,
    @required this.deliveryAmount,
    @required this.deliveryType,
    @required this.freeDeliveryCity,
  });

  Map<String, dynamic> toMap() {
    return {
      'aboveDeliveryFree': aboveDeliveryFree,
      'deliveryAmount': deliveryAmount,
      'deliveryType': deliveryType,
      'freeDeliveryCity': freeDeliveryCity,
    };
  }

  factory DeliveryPrice.fromMap(Map<String, dynamic> map) {
    return DeliveryPrice(
      aboveDeliveryFree: map['aboveDeliveryFree'],
      deliveryAmount: map['deliveryAmount'],
      deliveryType: map['deliveryType'],
      freeDeliveryCity: List<String>.from(map['freeDeliveryCity']),
    );
  }

  String toJson() => json.encode(toMap());

  factory DeliveryPrice.fromJson(String source) =>
      DeliveryPrice.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeliveryPrice &&
        other.aboveDeliveryFree == aboveDeliveryFree &&
        other.deliveryAmount == deliveryAmount &&
        other.deliveryType == deliveryType &&
        listEquals(other.freeDeliveryCity, freeDeliveryCity);
  }

  @override
  int get hashCode {
    return aboveDeliveryFree.hashCode ^
        deliveryAmount.hashCode ^
        deliveryType.hashCode ^
        freeDeliveryCity.hashCode;
  }
}
