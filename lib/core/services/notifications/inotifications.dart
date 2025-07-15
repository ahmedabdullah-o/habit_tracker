import 'package:habit_tracker/core/services/notifications/notification_model.dart';

abstract class Inotifications {
  Future<void> init();
  Future<void> send(NotificationModel notificationModel);
  Future<void> cancel(int notificationId);
  Future<void> cancelAll();
}
