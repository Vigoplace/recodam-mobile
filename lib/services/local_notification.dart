import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:recordam/utils/utils.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initilize(BuildContext context) {
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings("ic_notification"),
      iOS: DarwinInitializationSettings(),
    );

    _notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse details) {},
    );
  }

  static void showNotificationOnForeground(RemoteMessage message) async {
    var notificationDetail = const NotificationDetails(
      android: AndroidNotificationDetails(
        "org.recodam.mobile",
        "firebase_push_notification",
        importance: Importance.max,
        priority: Priority.high,
        playSound: true,
        visibility: NotificationVisibility.public,
        color: Colors.red,
        icon: '@drawable/ic_notification',
      ),
    );
    // var payload = NotificationPayload.fromJson(message.data);
    await _notificationsPlugin.show(
      DateTime.now().microsecond,
      message.notification?.title,
      message.notification?.body,
      notificationDetail,
      // payload: payload.toString(),
    );
  }
}
