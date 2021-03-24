import 'dart:convert';

import 'package:flutter/foundation.dart';

class NotificationData {
  final String title;
  final String message;
  final String imgpath;
  final String noticedate;
  final bool noticeRead;

  NotificationData({
    @required this.title,
    @required this.message,
    @required this.imgpath,
    @required this.noticedate,
    @required this.noticeRead,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is NotificationData &&
        other.title == title &&
        other.message == message &&
        other.imgpath == imgpath &&
        other.noticedate == noticedate &&
        other.noticeRead == noticeRead;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        message.hashCode ^
        imgpath.hashCode ^
        noticedate.hashCode ^
        noticeRead.hashCode;
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'message': message,
      'imgpath': imgpath,
      'noticedate': noticedate,
      'noticeRead': noticeRead,
    };
  }

  factory NotificationData.fromMap(Map<String, dynamic> map) {
    return NotificationData(
      title: map['title'],
      message: map['message'],
      imgpath: map['imgpath'],
      noticedate: map['noticedate'],
      noticeRead: map['noticeRead'],
    );
  }

  String toJson() => json.encode(toMap());

  factory NotificationData.fromJson(String source) =>
      NotificationData.fromMap(json.decode(source));
}
