import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  static final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();

  static const String channelId = 'learning_path_reminders';
  static const String channelName = 'Learning Reminders';
  static const String channelDescription =
      'Daily learning reminders and roadmap milestones';

  static Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await notifications.initialize(settings: initializationSettings);
  }

  static Future<bool> requestPermission() async {
    final AndroidFlutterLocalNotificationsPlugin? androidPlugin =
        notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    if (androidPlugin != null) {
      final bool? granted =
          await androidPlugin.requestNotificationsPermission();
      return granted ?? false;
    }

    final IOSFlutterLocalNotificationsPlugin? iosPlugin =
        notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();

    if (iosPlugin != null) {
      final bool? granted = await iosPlugin.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }

    return true;
  }

  static Future<void> showNotification({
    int id = 1,
    required String title,
    required String body,
    bool playSound = true,
  }) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      playSound: playSound,
      enableVibration: true,
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: playSound,
    );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await notifications.show(
      id: id,
      title: title,
      body: body,
      notificationDetails: notificationDetails,
    );
  }

  static Future<void> scheduleDailyReminder({bool playSound = true}) async {
    final AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
      'daily_reminder_channel',
      'Daily Learning Reminder',
      channelDescription: 'Daily alerts to keep your learning streak alive',
      importance: Importance.high,
      priority: Priority.high,
      playSound: playSound,
    );

    final DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: playSound,
    );

    final NotificationDetails details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await notifications.periodicallyShowWithDuration(
      id: 100,
      title: 'Keep Your Streak Alive! 🔥',
      body: 'Time to learn! Complete your next roadmap step today.',
      repeatDurationInterval: const Duration(days: 1),
      notificationDetails: details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
    );
  }

  static Future<void> cancelDailyReminder() async {
    await notifications.cancel(id: 100);
  }

  static Future<void> cancelAll() async {
    await notifications.cancelAll();
  }
}
