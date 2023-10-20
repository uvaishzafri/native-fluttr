import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalNotificationManager {
  // final NotificationRepository _notificationRepository;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  // final Rxn<Map<String, dynamic>> data = Rxn<Map<String, dynamic>>(null);
  ValueNotifier<String?> data = ValueNotifier(null);

  LocalNotificationManager(/*this._notificationRepository*/);

  Future<void> init() async {
    // tz.initializeTimeZones();
    final InitializationSettings initializationSettings = _getInitializationSettings();
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  Future<void> requestIosPermissions() async {
    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
          alert: true,
          badge: true,
          sound: true,
        );
  }

  // void listenForAlarms(User user) {
  //   _notificationRepository.getAlarms(user).listen((alarms) {
  //     _flutterLocalNotificationsPlugin.cancelAll().then((value) {
  //       for (Alarm alarm in alarms) {
  //         _scheduleNotification(alarm);
  //       }
  //     });
  //   });
  // }

  Future<NotificationAppLaunchDetails?> getNotificationAppLaunchDetails() {
    return _flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  }

  // Future<void> queueNotification({required String userId, required LocalNotificationType localNotificationType, required int id, required String title, required String description, required DateTime dateTime, String? payload}) async {
  //   Alarm alarm = Alarm(id: id, type: localNotificationType, title: title, description: description, startDate: dateTime, payload: payload);
  //   _notificationRepository.storeAlarm(userId: userId, alarm: alarm);
  // }

  // Future<void> cancelNotification(User? user, LocalNotificationType localNotificationType, int id) async {
  //   if (user == null) {
  //     return;
  //   }
  //   _notificationRepository.deleteAlarm(user, localNotificationType, id);
  // }

  // Future<void> updateNotification(User? user, LocalNotificationType localNotificationType, int id, String title, String description, DateTime dateTime) async {
  //   if (user == null) {
  //     return;
  //   }
  //   Alarm alarm = Alarm(id: id, type: localNotificationType, title: title, description: description, startDate: dateTime);
  //   _notificationRepository.updateAlarm(user, alarm);
  // }

  // Future<void> _scheduleNotification(Alarm alarm) async {
  //   final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
  //   tz.TZDateTime scheduledDate = tz.TZDateTime.from(alarm.startDate, tz.local);
  //   if (scheduledDate.isBefore(now) || alarm.id > 0x7FFFFFFF || alarm.id < -0x80000000) {
  //     return;
  //   }
  //   AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
  //     alarm.type.channelId,
  //     alarm.type.channelName,
  //     channelDescription: alarm.type.channelDescription,
  //     showWhen: false,
  //     color: CouplyColors.primaryColor,
  //   );
  //   await _flutterLocalNotificationsPlugin.zonedSchedule(
  //     alarm.id,
  //     alarm.title,
  //     alarm.description,
  //     scheduledDate,
  //     NotificationDetails(android: androidDetails),
  //     payload: alarm.payload,
  //     androidAllowWhileIdle: false,
  //     uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //   );
  // }

  InitializationSettings _getInitializationSettings() {
    const AndroidInitializationSettings androidSettings = AndroidInitializationSettings('logo_native');
    final DarwinInitializationSettings iosSettings = DarwinInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    // final MacOSInitializationSettings macSettings = MacOSInitializationSettings(
    //   requestSoundPermission: false,
    //   requestBadgePermission: false,
    //   requestAlertPermission: false,
    // );
    return InitializationSettings(
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

  void showLocalNotification({required RemoteMessage message}) {
    // LocalNotificationType  notificationType;
    // if(message.notification?.android?.channelId != null){
    //   notificationType = LocalNotificationType.values.elementAt(int.tryParse(message.notification!.android!.channelId!) ?? 3);
    // } else {
    //   notificationType = LocalNotificationType.general;
    // }
    AndroidNotificationDetails androidDetails = AndroidNotificationDetails('1', 'general');
    _flutterLocalNotificationsPlugin.show(
      1,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(android: androidDetails),
      payload: jsonEncode(message.data),
    );
  }
}
