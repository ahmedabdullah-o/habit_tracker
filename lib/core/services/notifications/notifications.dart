import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:habit_tracker/core/enums/notifications_enums.dart';
import 'package:habit_tracker/core/extensions/notifications_extensions.dart';
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

  Future<bool?> _isAndroidNotificationsEnabled() async {
    final bool? isEnabled = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.areNotificationsEnabled();
    return isEnabled;
  }

  Future<bool?> _isDarwinNotificationsEnabled() async {
    final NotificationsEnabledOptions? checkEnabled =
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin
            >()
            ?.checkPermissions() ??
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin
            >()
            ?.checkPermissions();
    final bool? isEnabled = checkEnabled?.isEnabled;
    return isEnabled;
  }

  @override
  void init() {
    final initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        notificationCategories: [
          // General Notifications
          DarwinNotificationCategory('general'),
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
    //Initialize Plugin
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: selectNotificationStream.add,
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    //Create channels
    final androidImplementation = flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    for (var value in NotificationDetailsEnum.values) {
      final notificationChannel = value.android.toAndroidNotificationChannel;
      androidImplementation?.createNotificationChannel(notificationChannel);
    }
    //Request permissions
    _requestPermissions();
  }

  @override
  Future<void> send(NotificationModel notificationModel) async {
    bool? isAndroidNotificationsEnabled =
        await _isAndroidNotificationsEnabled();
    bool? isDarwinNotificationsEnabled = await _isDarwinNotificationsEnabled();
    if ((isAndroidNotificationsEnabled ?? false) ||
        (isDarwinNotificationsEnabled ?? false)) {
      flutterLocalNotificationsPlugin.show(
        notificationModel.id,
        notificationModel.title,
        notificationModel.body,
        notificationModel.notificationDetails.details,
        payload: notificationModel.payload,
      );
    }
  }

  @override
  void cancel(int notificationId) {
    flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  @override
  void cancelAll() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  @override
  void cancelAllScheduled() {
    flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
  }
}
