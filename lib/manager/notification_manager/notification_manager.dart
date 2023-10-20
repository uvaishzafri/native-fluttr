import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:injectable/injectable.dart';
import 'package:native/model/user.dart';
import 'package:native/repo/firestore_repository.dart';

@lazySingleton
class NotificationManager {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  // final UserRepository _userRepository;
  // final FirestoreRepository _firestoreRepository;
  // bool _initialized = false;
  // User? _user;

  NotificationManager();

  // set user(User user) => _user = user;

  // Future<void> init() async {
  //   if (!_initialized) {
  //     String? token = await _firebaseMessaging.getToken();
  //     if (token != null) {
  //       storeToken(token);
  //     }

  //     _firebaseMessaging.onTokenRefresh.listen((String token) {
  //       storeToken(token);
  //     });

  //     _initialized = true;
  //   }
  // }

  void setForegroundMessageCallback(void handler(RemoteMessage remoteMessage)) {
    FirebaseMessaging.onMessage.listen(handler);
  }

  void setBackgroundMessageOpenedCallback(void handler(RemoteMessage remoteMessage)) {
    FirebaseMessaging.onMessageOpenedApp.listen(handler);
  }

  void setBackgroundMessageCallback(Future<void> handler(RemoteMessage remoteMessage)) {
    FirebaseMessaging.onBackgroundMessage(handler);
  }

  // Future<void> storeToken(String token) async {
  //   if (_user != null) {
  //     _firestoreRepository.updateUserDeviceToken(_user!.uid!, token);
  //     // _userRepository.storeUserFcmToken(_user!.id, token);
  //   }
  // }
}
