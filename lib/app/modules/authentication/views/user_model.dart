import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserAuth {
  final String email;
  final String password;
  final String displayname;
  UserAuth({
    @required this.email,
    @required this.password,
    this.displayname,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserAuth &&
        other.email == email &&
        other.password == password &&
        other.displayname == displayname;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode ^ displayname.hashCode;

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'displayname': displayname,
    };
  }

  factory UserAuth.fromMap(Map<String, dynamic> map) {
    return UserAuth(
      email: map['email'],
      password: map['password'],
      displayname: map['displayname'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserAuth.fromJson(String source) =>
      UserAuth.fromMap(json.decode(source));
}
