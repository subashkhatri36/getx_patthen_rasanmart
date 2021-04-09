import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserCoupen {
  final int totalpurchase;
  final double totalpurchaseCash;
  UserCoupen({
    @required this.totalpurchase,
    @required this.totalpurchaseCash,
  });

  Map<String, dynamic> toMap() {
    return {
      'totalpurchase': totalpurchase,
      'totalpurchaseCash': totalpurchaseCash,
    };
  }

  factory UserCoupen.fromMap(Map<String, dynamic> map) {
    return UserCoupen(
      totalpurchase: map['totalpurchase'],
      totalpurchaseCash: map['totalpurchaseCash'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCoupen.fromJson(String source) =>
      UserCoupen.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserCoupen &&
        other.totalpurchase == totalpurchase &&
        other.totalpurchaseCash == totalpurchaseCash;
  }

  @override
  int get hashCode => totalpurchase.hashCode ^ totalpurchaseCash.hashCode;
}
