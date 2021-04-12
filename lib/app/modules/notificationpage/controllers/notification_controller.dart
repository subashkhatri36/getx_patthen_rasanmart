import 'dart:math';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/Widgets/snakbar.dart';
import 'package:rasan_mart/app/data/notification/notification_repositories.dart';
import 'package:rasan_mart/app/modules/notificationpage/providers/notification_provider.dart';
import 'package:rasan_mart/app/modules/home/views/notification_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  RxList<NotificationData> notificationList;
  var rng = new Random();

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationProvider notificationProvider = new NotificationRepository();
  RxInt notification = 0.obs;
  RxBool togglenotice = false.obs;

  @override
  void onInit() {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kathmandu'));

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    final MacOSInitializationSettings initializationSettingsMacOS =
        MacOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false);
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS,
            macOS: initializationSettingsMacOS);
    load(initializationSettings);
    fetchNotification();
    //showNotification('Hello', 'How are you', 0, '');

    super.onInit();
  }

  fetchNotification() async {
    var user = FirebaseAuth.instance.currentUser;
    List<NotificationData> newNotification = [];
    if (user != null) {
      String id = user.uid;
      Either<String, List<NotificationData>> data =
          await notificationProvider.fetchNotification(id);
      data.fold((l) => print(l), (r) {
        newNotification = r.toList();
        notificationList = newNotification.obs;
        checkList(false);
      });
    }
  }

  checkList(bool update) {
    notification.value = 0;
    List<NotificationData> updated = [];
    notificationList.forEach((element) {
      if (update) {
        element.noticeRead = true;
        updated.add(element);
      }
      if (!element.noticeRead) notification.value++;
    });
    print(notification.value);

    if (update) {
      notificationList = updated.obs;
      notification.value = 0;
    }
    if (notification.value > 0)
      for (int i = 0; i < notificationList.length; i++) {
        if (!notificationList[i].noticeRead)
          showNotification(notificationList[i].title,
              notificationList[i].message, i, notificationList[i].payload);
      }
  }

  void addNotification(NotificationData data) async {
    if (notificationList == null) notificationList = [].obs;
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      Either<String, String> adding =
          await notificationProvider.addNotification(id, data);
      adding.fold((l) => print(l), (r) {
        data.id = r;

        notificationList.add(data);
        notification.value++;
        print(notification.value);
        print(r);
        print(notificationList.length);
        scheduleNotification(
            id: rng.nextInt(50),
            title: 'Order Delivery',
            body:
                'Thank you for choosing us. Your Orders items will be delivered with in 48 hours.\nYour Order Id: $r\n Thank you.',
            duration: 5);
        checkList(false);
      });
    }
  }

  Future<bool> deleteNotification(NotificationData data) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      Either<String, String> deleting =
          await notificationProvider.deleteNotification(id, data);
      deleting.fold((l) {
        print(l);
        return false;
      }, (r) {
        CustomeSnackbar(title: 'Deletion', message: r, icon: Icon(Icons.info));
        notificationList.remove(data);
        checkList(false);
        return true;
      });
    } else {
      return false;
    }
    return false;
  }

  void clearNotification() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      Either<String, void> cancelling =
          await notificationProvider.clearNotification(id, notificationList);
      cancelling.fold(
          (l) => CustomeSnackbar(
              title: 'Error !', message: l, icon: Icon(Icons.error)), (r) {
        notificationList.clear();
        notification.value = 0;
      });
    }
  }

  void updateNotification() async {
    togglenotice.toggle();
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String id = user.uid;
      Either<String, void> updateedall =
          await notificationProvider.updateNotification(id, notificationList);
      updateedall.fold((l) => print(l), (r) {
        checkList(true);
      });
    }
    togglenotice.toggle();
  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }

  showNotification(String title, String body, int id, String payload) async {
    var android = new AndroidNotificationDetails(
        'id', 'channel ', 'description',
        priority: Priority.high, importance: Importance.max);
    var iOS = new IOSNotificationDetails();
    var platform = new NotificationDetails(android: android, iOS: iOS);
    await flutterLocalNotificationsPlugin.show(id, title, body, platform,
        payload: payload);
  }

  load(InitializationSettings initializationSettings) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future selectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
      //Get.to(()=>PageProductView())
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    // display a dialog with the notification details, tap ok to go to another page
    Get.dialog(
        Container(
          child: Column(
            children: [Text(title), Text(body)],
          ),
        ),
        barrierDismissible: true);
  }

  scheduleNotification(
      {@required int id,
      @required String title,
      @required String body,
      @required int duration}) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(Duration(seconds: duration)),
        const NotificationDetails(
            android: AndroidNotificationDetails('your channel id',
                'your channel name', 'your channel description')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  repeatedShowNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('repeating channel id',
            'repeating channel name', 'repeating description');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.periodicallyShow(0, 'repeating title',
        'repeating body', RepeatInterval.everyMinute, platformChannelSpecifics,
        androidAllowWhileIdle: true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
