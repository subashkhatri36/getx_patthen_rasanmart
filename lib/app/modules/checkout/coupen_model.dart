import 'dart:convert';

import 'package:flutter/foundation.dart';

class Coupen {
  final double coupenAmount;
  final String coupenType;
  final double coupenlimit;
  final int totalpurchase;
  Coupen({
    @required this.coupenAmount,
    @required this.coupenType,
    @required this.coupenlimit,
    @required this.totalpurchase,
  });

  Map<String, dynamic> toMap() {
    return {
      'coupenAmount': coupenAmount,
      'coupenType': coupenType,
      'coupenlimit': coupenlimit,
      'totalpurchase': totalpurchase,
    };
  }

  factory Coupen.fromMap(Map<String, dynamic> map) {
    return Coupen(
      coupenAmount: map['coupenAmount'],
      coupenType: map['coupenType'],
      coupenlimit: map['coupenlimit'],
      totalpurchase: map['totalpurchase'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Coupen.fromJson(String source) => Coupen.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Coupen &&
        other.coupenAmount == coupenAmount &&
        other.coupenType == coupenType &&
        other.coupenlimit == coupenlimit &&
        other.totalpurchase == totalpurchase;
  }

  @override
  int get hashCode {
    return coupenAmount.hashCode ^
        coupenType.hashCode ^
        coupenlimit.hashCode ^
        totalpurchase.hashCode;
  }
}
