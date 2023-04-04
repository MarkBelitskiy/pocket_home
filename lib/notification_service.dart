import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();
  factory NotificationService() {
    return _notificationService;
  }
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> init() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(android: AndroidInitializationSettings('@mipmap/launcher_icon'));
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  Future showNotificationWithoutSound({required int id, required String title, required String msg}) async {
    const platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails('0', 'pocket_home',
          autoCancel: false, playSound: false, importance: Importance.max, priority: Priority.high),
    );
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      msg,
      platformChannelSpecifics,
    );
  }
}
