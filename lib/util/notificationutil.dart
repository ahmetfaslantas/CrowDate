import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationUtil {
  static final NotificationUtil _notificationUtil =
      NotificationUtil._internal();

  factory NotificationUtil() {
    return _notificationUtil;
  }

  NotificationUtil._internal();

  static const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails('CrowDate', 'Event Reminder',
          channelDescription: 'This Channel is Used for Event Reminders',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker');

  static const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, iOS: null, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(int id, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        id, title, body, platformChannelSpecifics);
  }
}
