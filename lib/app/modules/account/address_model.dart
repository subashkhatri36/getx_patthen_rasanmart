import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddressModel {
  final String place;
  final String tol;
  final String city;
  final String muncipalit;
  final String state;
  final zipcode;
  final phoneno;
  final landmark;

  AddressModel({
    @required this.place,
    this.tol,
    @required this.city,
    @required this.muncipalit,
    @required this.state,
    @required this.zipcode,
    @required this.phoneno,
    this.landmark,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.place == place &&
        other.tol == tol &&
        other.city == city &&
        other.muncipalit == muncipalit &&
        other.state == state;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        tol.hashCode ^
        city.hashCode ^
        muncipalit.hashCode ^
        state.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'tol': tol,
      'city': city,
      'muncipalit': muncipalit,
      'state': state,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      place: map['place'],
      tol: map['tol'],
      city: map['city'],
      muncipalit: map['muncipalit'],
      state: map['state'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));
}
