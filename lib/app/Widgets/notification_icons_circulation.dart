import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';

class IconWithNotification extends StatelessWidget {
  final IconData icon;
  final String notification;
  final Color backgroundColor;

  const IconWithNotification({
    Key key,
    this.icon,
    this.notification,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10),
      child: Stack(
        children: [
          Icon(
            icon,
            size: 30,
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(10)),
              child: CircleAvatar(
                foregroundColor: Colors.white,
                backgroundColor:
                    backgroundColor ?? Theme.of(context).backgroundColor,
                radius: 7,
                child: Text(
                  notification ?? 0,
                  style: TextStyle(fontSize: Defaults.defaultfontsize - 4),
                ),
              ),
            ),
          )
          //CircularContainer(),
        ],
      ),
    );
  }
}
