import 'package:flutter/material.dart';
import 'package:rasan_mart/app/core/constant/default_value.dart';
import 'package:rasan_mart/app/core/constant/strings.dart';
import 'package:rasan_mart/app/core/utils/styles.dart';
import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/searchpage/controllers/searchpage_controller.dart';
import 'package:rasan_mart/app/modules/searchpage/views/searchpage_view.dart';
import 'package:get/get.dart';

class SearchBarIcon extends StatelessWidget {
  final val;

  const SearchBarIcon({Key key, this.val}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(SearchpageController());
    return GestureDetector(
      onTap: () {
        Get.to(() => SearchpageView());
      },
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Defaults.defaultPadding,
            vertical: Defaults.defaultPadding / 2),
        padding: EdgeInsets.all(Defaults.defaultPadding / 2),
        decoration: buildBoxDecoration(
            bgcolor: Theme.of(context).primaryColor, shadow: true, round: true),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.search,
              color: Theme.of(context).accentColor,
            ),
            SizedBox(width: 10),
            Text(
              Strings.searchMessage,
              style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
