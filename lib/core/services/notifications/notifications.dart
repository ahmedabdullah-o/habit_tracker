import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_tracker/core/services/notifications/inotifications.dart';
import 'package:habit_tracker/core/services/notifications/notification_model.dart';

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialized in the `main` function
final StreamController<NotificationResponse> selectNotificationStream =
    StreamController<NotificationResponse>.broadcast();

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  if (notificationResponse.actionId == 'habit_snooze') {
    // TODO:implement habit_snooze action
    throw UnimplementedError();
  } else if (notificationResponse.actionId == 'habit_done') {
    // TODO:implement habit_done action
    throw UnimplementedError();
  }
}

class Notifications implements Inotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> _requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            MacOSFlutterLocalNotificationsPlugin
          >()
          ?.requestPermissions(alert: true, badge: true, sound: true);
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
          flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin
              >();
      await androidImplementation?.requestNotificationsPermission();
    }
  }

  @override
  void init() {
    _requestPermissions();
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        notificationCategories: [
          // Normal habit notification
          DarwinNotificationCategory(
            'habit',
            actions: [
              DarwinNotificationAction.plain('habit_snooze', 'snooze'),
              DarwinNotificationAction.plain('habit_done', 'done'),
            ],
          ),
        ],
      ),
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotificationStream.add,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
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
