import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@lazySingleton
class LocalNotificationManager {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  ValueNotifier<String?> data = ValueNotifier(null);

  LocalNotificationManager();

  Future<void> init() async {
    final InitializationSettings initializationSettings = _getInitializationSettings();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  Future<void> requestIosPermissions() async {
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() {
    return _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  InitializationSettings _getInitializationSettings() {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('logo_native');
    const DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    return const InitializationSettings(
      android: androidSettings,
      iOS: iosSettings, /* macOS: macSettings*/
    );
  }

  // Future<void> _onSelectNotification(String? payload) async {
  //   if (payload != null) {
  //     data.value = jsonDecode(payload);
  //   }
  // }

  void _onDidReceiveNotificationResponse(NotificationResponse response) async {
    if (response.payload != null) {
      data.value = response.payload!;
      // data.value = jsonDecode(response.payload!);
    }
  }

  void showLocalNotification({required RemoteMessage message}) async {
    final prefs = await SharedPreferences.getInstance();
    final notificationSettingsJson = prefs.getString('notificationSettings');
    if (notificationSettingsJson != null) {
      final notificationSetting = jsonDecode(notificationSettingsJson);
      switch (message.data['type']) {
        case 'LIKED':
          if (notificationSetting['likes']) {
            break;
          } else {
            return;
          }
        case 'CHAT':
          if (notificationSetting['messages']) {
            break;
          } else {
            return;
          }
        default:
          break;
      }
    }
    AndroidNotificationDetails androidDetails = const AndroidNotificationDetails('1', 'general');
    _flutterLocalNotificationsPlugin.show(
      1,
      message.data['title'],
      message.data['body'],
      NotificationDetails(android: androidDetails),
      payload: jsonEncode(message.data),
    );
  }
}
