import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/firestore_repository.dart';

@lazySingleton
class NotificationManager {
  NotificationManager();

  void setForegroundMessageCallback(void Function(RemoteMessage remoteMessage) handler) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  void setBackgroundMessageOpenedCallback(void Function(RemoteMessage remoteMessage) handler) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  void setBackgroundMessageCallback(Future<void> Function(RemoteMessage remoteMessage) handler) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }
}
