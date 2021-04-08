import 'package:dartz/dartz.dart';
import 'package:rasan_mart/app/modules/home/views/notification_model.dart';

abstract class NotificationProvider {
  Future<Either<String, List<NotificationData>>> fetchNotification(
      String userId);
  Future<Either<String, String>> clearNotification(String userId);
  Future<Either<String, void>> updateNotification(
      String userId, List<NotificationData> notification);
  Future<Either<String, String>> addNotification(
      String userId, NotificationData notification);
  Future<Either<String, String>> deleteNotification(
      String userId, NotificationData notification);
}
