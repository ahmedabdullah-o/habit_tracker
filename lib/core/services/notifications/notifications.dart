import 'dart:async';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/standalone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:habit_tracker/core/enums/notifications_enums.dart';
import 'package:habit_tracker/core/extensions/notifications_extensions.dart';
import 'package:habit_tracker/core/services/notifications/inotifications.dart';
import 'package:habit_tracker/core/services/notifications/notification_model.dart';
import 'package:logging/logging.dart';

/// Streams are created so that app can respond to notification-related events
/// since the plugin is initialized in the `main` function
final StreamController<NotificationResponse> selectNotificationStream =
    StreamController<NotificationResponse>.broadcast();

final Logger _backgroundLogger = Logger(
  'HabitTracker.Services.Notifications.Background',
);

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  _backgroundLogger.info(
    'notificationTapBackground: Notification tapped in background',
  );
  _backgroundLogger.fine(
    'notificationTapBackground: Response - id: ${notificationResponse.id}, actionId: ${notificationResponse.actionId}, payload: ${notificationResponse.payload}',
  );

  if (notificationResponse.actionId == 'habit_snooze') {
    _backgroundLogger.warning(
      'notificationTapBackground: habit_snooze action triggered - NOT IMPLEMENTED',
    );
    // TODO:implement habit_snooze action
    throw UnimplementedError();
  } else if (notificationResponse.actionId == 'habit_done') {
    _backgroundLogger.warning(
      'notificationTapBackground: habit_done action triggered - NOT IMPLEMENTED',
    );
    // TODO:implement habit_done action
    throw UnimplementedError();
  } else {
    _backgroundLogger.fine(
      'notificationTapBackground: Unknown or default action',
    );
  }
}

class Notifications implements Inotifications {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  Notifications(this.flutterLocalNotificationsPlugin) {
    _logger.info('Notifications: Service instance created');
  }

  static final Logger _logger = Logger('HabitTracker.Services.Notifications');

  Future<bool?> _isAndroidNotificationsEnabled() async {
    _logger.fine(
      '_isAndroidNotificationsEnabled: Checking Android notifications status',
    );

    try {
      final bool? isEnabled = await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.areNotificationsEnabled();

      _logger.info(
        '_isAndroidNotificationsEnabled: Android notifications enabled: $isEnabled',
      );
      return isEnabled;
    } catch (e, stackTrace) {
      _logger.severe(
        '_isAndroidNotificationsEnabled: Error checking Android notifications',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  Future<bool?> _isDarwinNotificationsEnabled() async {
    _logger.fine(
      '_isDarwinNotificationsEnabled: Checking Darwin (iOS/macOS) notifications status',
    );

    try {
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
      _logger.info(
        '_isDarwinNotificationsEnabled: Darwin notifications enabled: $isEnabled',
      );
      _logger.fine(
        '_isDarwinNotificationsEnabled: Full permissions - isEnabled: ${checkEnabled?.isEnabled}, alert: ${checkEnabled?.isAlertEnabled}, badge: ${checkEnabled?.isBadgeEnabled}, sound: ${checkEnabled?.isSoundEnabled}',
      );

      return isEnabled;
    } catch (e, stackTrace) {
      _logger.severe(
        '_isDarwinNotificationsEnabled: Error checking Darwin notifications',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  void init() {
    _logger.info('init: Initializing Notifications service');

    try {
      // Initialize timezone database
      _logger.fine('init: Initializing timezone database');
      tz.initializeTimeZones();
      _logger.fine('init: Timezone database initialized');

      // Setup initialization settings
      _logger.fine('init: Creating initialization settings');
      final initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(
          notificationCategories: [
            DarwinNotificationCategory('general'),
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
      _logger.fine('init: Initialization settings created');

      // Initialize Plugin
      _logger.fine('init: Initializing FlutterLocalNotificationsPlugin');
      flutterLocalNotificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (response) {
          _logger.info(
            'init: Notification response received - id: ${response.id}, actionId: ${response.actionId}',
          );
          selectNotificationStream.add(response);
        },
        onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      );
      _logger.info('init: FlutterLocalNotificationsPlugin initialized');

      // Create Android notification channels
      _logger.fine('init: Creating Android notification channels');
      final androidImplementation = flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >();

      int channelCount = 0;
      for (var value in NotificationDetailsEnum.values) {
        try {
          final notificationChannel =
              value.android.toAndroidNotificationChannel;
          androidImplementation?.createNotificationChannel(notificationChannel);
          channelCount++;
          _logger.finer('init: Created channel - ${value.name}');
        } catch (e, stackTrace) {
          _logger.severe(
            'init: Error creating channel ${value.name}',
            e,
            stackTrace,
          );
        }
      }
      _logger.info('init: Created $channelCount Android notification channels');

      // Request permissions
      _logger.fine('init: Requesting notification permissions');
      requestPermissions();

      _logger.info('init: Notifications service initialization complete');
    } catch (e, stackTrace) {
      _logger.severe('init: Fatal error during initialization', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool?> isPermissionGranted() async {
    _logger.fine(
      'isPermissionGranted: Checking notification permissions for platform: ${Platform.operatingSystem}',
    );

    try {
      bool? result;

      if (Platform.isAndroid) {
        _logger.fine('isPermissionGranted: Checking Android permissions');
        result = await _isAndroidNotificationsEnabled();
      } else if (Platform.isIOS) {
        _logger.fine('isPermissionGranted: Checking iOS permissions');
        result = await _isDarwinNotificationsEnabled();
      } else {
        _logger.warning(
          'isPermissionGranted: Unsupported platform: ${Platform.operatingSystem}',
        );
        result = false;
      }

      _logger.info('isPermissionGranted: Permission granted: $result');
      return result;
    } catch (e, stackTrace) {
      _logger.severe(
        'isPermissionGranted: Error checking permissions',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> requestPermissions() async {
    _logger.info(
      'requestPermissions: Requesting notification permissions for platform: ${Platform.operatingSystem}',
    );

    try {
      if (Platform.isIOS || Platform.isMacOS) {
        _logger.fine('requestPermissions: Requesting iOS/macOS permissions');

        if (Platform.isIOS) {
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                IOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true);
          _logger.info('requestPermissions: iOS permissions requested');
        }

        if (Platform.isMacOS) {
          await flutterLocalNotificationsPlugin
              .resolvePlatformSpecificImplementation<
                MacOSFlutterLocalNotificationsPlugin
              >()
              ?.requestPermissions(alert: true, badge: true, sound: true);
          _logger.info('requestPermissions: macOS permissions requested');
        }
      } else if (Platform.isAndroid) {
        _logger.fine('requestPermissions: Requesting Android permissions');
        final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
            flutterLocalNotificationsPlugin
                .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin
                >();
        await androidImplementation?.requestNotificationsPermission();
        _logger.info('requestPermissions: Android permissions requested');
      } else {
        _logger.warning(
          'requestPermissions: Unsupported platform: ${Platform.operatingSystem}',
        );
      }

      _logger.info('requestPermissions: Permission request complete');
    } catch (e, stackTrace) {
      _logger.severe(
        'requestPermissions: Error requesting permissions',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> send(NotificationModel notificationModel) async {
    _logger.info(
      'send: Sending notification - id: ${notificationModel.id}, title: "${notificationModel.title}"',
    );
    _logger.fine(
      'send: Notification details - body: "${notificationModel.body}", payload: ${notificationModel.payload}',
    );

    try {
      bool? isAndroidNotificationsEnabled =
          await _isAndroidNotificationsEnabled();
      bool? isDarwinNotificationsEnabled =
          await _isDarwinNotificationsEnabled();

      final isEnabled =
          (isAndroidNotificationsEnabled ?? false) ||
          (isDarwinNotificationsEnabled ?? false);

      _logger.fine(
        'send: Notifications enabled - Android: $isAndroidNotificationsEnabled, Darwin: $isDarwinNotificationsEnabled, Overall: $isEnabled',
      );

      if (isEnabled) {
        await flutterLocalNotificationsPlugin.show(
          notificationModel.id,
          notificationModel.title,
          notificationModel.body,
          notificationModel.notificationDetails.details,
          payload: notificationModel.payload,
        );
        _logger.info(
          'send: Notification sent successfully - id: ${notificationModel.id}',
        );
      } else {
        _logger.warning(
          'send: Notification not sent - permissions not granted for id: ${notificationModel.id}',
        );
      }
    } catch (e, stackTrace) {
      _logger.severe(
        'send: Error sending notification id: ${notificationModel.id}',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<void> schedule(
    NotificationModel notificationModel,
    DateTime scheduleAt, {
    DateTimeComponents? matchDateTimeComponents,
  }) async {
    _logger.info(
      'schedule: Scheduling notification - id: ${notificationModel.id}, title: "${notificationModel.title}", scheduleAt: $scheduleAt',
    );
    _logger.fine(
      'schedule: Match components: $matchDateTimeComponents, body: "${notificationModel.body}", payload: ${notificationModel.payload}',
    );

    try {
      final locationName = await FlutterTimezone.getLocalTimezone();
      _logger.fine('schedule: Local timezone: $locationName');

      final location = tz.getLocation(locationName);
      final tzDateTime = tz.TZDateTime.from(scheduleAt, location);

      _logger.fine('schedule: Converted to TZDateTime: $tzDateTime');

      await flutterLocalNotificationsPlugin.zonedSchedule(
        notificationModel.id,
        notificationModel.title,
        notificationModel.body,
        tzDateTime,
        payload: notificationModel.payload,
        notificationModel.notificationDetails.details,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        matchDateTimeComponents: matchDateTimeComponents,
      );

      _logger.info(
        'schedule: Notification scheduled successfully - id: ${notificationModel.id}, at: $tzDateTime',
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'schedule: Error scheduling notification id: ${notificationModel.id}',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  void cancel(int notificationId) {
    _logger.info('cancel: Cancelling notification - id: $notificationId');

    try {
      flutterLocalNotificationsPlugin.cancel(notificationId);
      _logger.info(
        'cancel: Notification cancelled successfully - id: $notificationId',
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'cancel: Error cancelling notification id: $notificationId',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  void cancelAll() {
    _logger.info('cancelAll: Cancelling all notifications');

    try {
      flutterLocalNotificationsPlugin.cancelAll();
      _logger.info('cancelAll: All notifications cancelled successfully');
    } catch (e, stackTrace) {
      _logger.severe(
        'cancelAll: Error cancelling all notifications',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  void cancelAllScheduled() {
    _logger.info('cancelAllScheduled: Cancelling all scheduled notifications');

    try {
      flutterLocalNotificationsPlugin.cancelAllPendingNotifications();
      _logger.info(
        'cancelAllScheduled: All scheduled notifications cancelled successfully',
      );
    } catch (e, stackTrace) {
      _logger.severe(
        'cancelAllScheduled: Error cancelling all scheduled notifications',
        e,
        stackTrace,
      );
      rethrow;
    }
  }
}
