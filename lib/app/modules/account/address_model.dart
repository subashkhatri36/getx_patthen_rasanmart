import 'dart:convert';

import 'package:flutter/foundation.dart';

class AddressModel {
  final String place;
  final String tol;
  final String city;
  final String muncipalit;
  final String state;
  final String zipcode;
  final String phoneno;
  final String landmark;
  bool isSelected;
  String id;

  AddressModel({
    @required this.place,
    this.tol,
    @required this.city,
    @required this.muncipalit,
    @required this.state,
    @required this.zipcode,
    @required this.phoneno,
    this.landmark = '',
    @required this.isSelected,
    this.id,
  });
  //bool setSelected(bool val) => this.isSelected = val;

  Map<String, dynamic> toMap() {
    return {
      'place': place,
      'tol': tol,
      'city': city,
      'muncipalit': muncipalit,
      'state': state,
      'zipcode': zipcode,
      'phoneno': phoneno,
      'landmark': landmark,
      'isSelected': isSelected,
    };
  }

  factory AddressModel.fromMap(Map<String, dynamic> map) {
    return AddressModel(
      place: map['place'],
      tol: map['tol'],
      city: map['city'],
      muncipalit: map['muncipalit'],
      state: map['state'],
      zipcode: map['zipcode'],
      phoneno: map['phoneno'],
      landmark: map['landmark'] ?? "",
      isSelected: map['isSelected'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AddressModel.fromJson(String source) =>
      AddressModel.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddressModel &&
        other.place == place &&
        other.tol == tol &&
        other.city == city &&
        other.muncipalit == muncipalit &&
        other.state == state &&
        other.zipcode == zipcode &&
        other.phoneno == phoneno &&
        other.landmark == landmark &&
        other.isSelected == isSelected;
  }

  @override
  int get hashCode {
    return place.hashCode ^
        tol.hashCode ^
        city.hashCode ^
        muncipalit.hashCode ^
        state.hashCode ^
        zipcode.hashCode ^
        phoneno.hashCode ^
        landmark.hashCode ^
        isSelected.hashCode;
  }

  @override
  String toString() {
    return 'AddressModel(place: $place, tol: $tol, city: $city, muncipalit: $muncipalit, state: $state, zipcode: $zipcode, phoneno: $phoneno, landmark: $landmark, isSelected: $isSelected, id: $id)';
  }

  String get fullAddress =>
      landmark.capitalize() +
      ' ' +
      tol.capitalize() +
      ' ' +
      place +
      ', ' +
      city +
      ', ' +
      muncipalit +
      ', ' +
      state +
      ',' +
      zipcode +
      ' \n' +
      'Phone : ' +
      phoneno;
}

extension StringExtension on String {
  String capitalize() {
    if (this.isNotEmpty) if (this[0].isNotEmpty)
      return "${this[0].toUpperCase()}${this.substring(1)}";

    return '';
  }
}
