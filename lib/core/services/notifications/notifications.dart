import 'package:habit_tracker/core/services/notifications/inotifications.dart';
import 'package:habit_tracker/core/services/notifications/notification_model.dart';

class Notifications implements Inotifications {
  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }

  @override
  Future<void> send(NotificationModel notificationModel) {
    // TODO: implement send
    throw UnimplementedError();
  }

  @override
  Future<void> cancel(int notificationId) {
    // TODO: implement cancel
    throw UnimplementedError();
  }

  @override
  Future<void> cancelAll() {
    // TODO: implement cancelAll
    throw UnimplementedError();
  }
}
