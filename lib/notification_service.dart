import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

class NotificationService {
  Future showNotification({required String title, required String msg}) async {
    const MethodChannel channel = MethodChannel('pocket_home/notification');

    try {
      await channel.invokeMethod('showNotification', {'title': title, 'message': msg});
    } on PlatformException catch (exception) {
      if (kDebugMode) {
        print('EXCEPTION_ON_NOTIFICATION_SERVICE: $exception');
      }
    }
  }
}
