import 'package:habit_tracker/core/services/notifications/notification_model.dart';

abstract class Inotifications {
  void init();
  Future<void> send(NotificationModel notificationModel);
  void cancel(int notificationId);
  void cancelAll();
}
