import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationData {
  String id;
  final String title;
  final String message;
  final String imgpath;
  final String noticedate;
  bool noticeRead;
  final String payload;

  NotificationData({
    @required this.title,
    @required this.message,
    @required this.imgpath,
    @required this.noticedate,
    @required this.noticeRead,
    this.payload = '',
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'imgpath': imgpath,
      'noticedate': noticedate,
      'noticeRead': noticeRead,
      'payload': payload,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      title: map['title'],
      message: map['message'],
      imgpath: map['imgpath'],
      noticedate: map['noticedate'],
      noticeRead: map['noticeRead'],
      payload: map['payload'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationData &&
        other.title == title &&
        other.message == message &&
        other.imgpath == imgpath &&
        other.noticedate == noticedate &&
        other.noticeRead == noticeRead &&
        other.payload == payload;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        message.hashCode ^
        imgpath.hashCode ^
        noticedate.hashCode ^
        noticeRead.hashCode ^
        payload.hashCode;
  }
}
