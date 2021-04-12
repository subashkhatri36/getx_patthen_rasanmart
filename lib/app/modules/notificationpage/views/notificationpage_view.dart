import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/theme/app_theme.dart';
import 'package:rasan_mart/app/modules/addAddress/views/view_address_widget.dart';
import 'package:rasan_mart/app/modules/home/views/notification_model.dart';

import '../controllers/notification_controller.dart';

class NotificationpageView extends GetView<NotificationController> {
  @override
  Widget build(BuildContext context) {
    controller.updateNotification();
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).backgroundColor,
          title: Text('Notification'),
          actions: [
            Container(
                padding: EdgeInsets.all(Defaults.defaultfontsize / 3),
                child: IconButton(
                    onPressed: () {
                      controller.clearNotification();
                    },
                    icon: Icon(Icons.clear_all)))
          ],
        ),
        body: Obx(() => controller.notificationList.length > 0
            ? controller.togglenotice.value
                ? CustomeNotificationList(
                    controller: controller,
                  )
                : CustomeNotificationList(
                    controller: controller,
                  )
            : Container(
                child: Center(
                  child: Text(
                    'No Notifications.',
                    style: TextStyle(color: Themes.lightcounterbtnColor),
                  ),
                ),
              )));
  }
}

class CustomeNotificationList extends StatelessWidget {
  const CustomeNotificationList({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        reverse: true,
        itemCount: controller.notificationList?.length ?? 0,
        itemBuilder: (context, index) {
          NotificationData notify = controller.notificationList[index];
          return Dismissible(
              background: slideLeftBackground(),
              key: Key(index.toString()),
              onDismissed: (direction) async {
                bool val = await controller.deleteNotification(notify);
                //controller.notificationList.removeAt(index);
                return val;
              },
              child: NotificationItems(notify: notify));
        });
  }
}

class NotificationItems extends StatelessWidget {
  const NotificationItems({
    Key key,
    @required this.notify,
  }) : super(key: key);

  final NotificationData notify;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Defaults.defaultfontsize / 2),
      padding: EdgeInsets.all(Defaults.defaultfontsize / 2),
      decoration: BoxDecoration(
          border: Border.all(
              color: notify.noticeRead
                  ? Colors.grey[100]
                  : Themes.lightcounterbtnColor)),
      child: ListTile(
        leading: notify.imgpath.isNotEmpty
            ? CircleAvatar(
                backgroundColor: Colors.white,
                foregroundColor: Themes.lightSalesolor,
                radius: Defaults.defaultPadding + 10,
                backgroundImage: NetworkImage(
                  notify.imgpath,
                ))
            : null,
        isThreeLine: true,
        title: Text(
          notify.title,
          style: TextStyle(
            color: notify.noticeRead ? Colors.black26 : Colors.black87,
          ),
        ),
        subtitle: Text(
          notify.message,
          style: TextStyle(
            color: notify.noticeRead ? Colors.black26 : Colors.black87,
          ),
        ),
      ),
    );
  }
}
