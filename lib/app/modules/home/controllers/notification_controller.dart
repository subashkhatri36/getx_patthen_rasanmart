import 'package:get/get.dart';
import 'package:rasan_mart/app/modules/home/views/notification_model.dart';

class NotificationController extends GetxController {
  List<NotificationData> notificationList;

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
