import 'package:recordam/services/local_notification.dart';
import 'package:recordam/utils/utils.dart';

class RecodamFirebaseService {
  static void initNotification(BuildContext context) async {
    LocalNotificationService.initilize(context);
    await FirebaseMessaging.instance.requestPermission();
    // Terminated State
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if (event != null) {
        debugPrint('GABBYGREAT TERMINATED');
      }
    });
    // Foreground State
    FirebaseMessaging.onMessage.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      debugPrint('GABBYGREAT FORE');
    });
    // Background State
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      LocalNotificationService.showNotificationOnForeground(event);
      debugPrint('GABBYGREAT BACK');
    });
  }
}
