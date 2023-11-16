import 'dart:io';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:native/manager/notification_manager/local_notification_manager.dart';
import 'package:native/manager/notification_manager/notification_manager.dart';
import 'package:permission_handler/permission_handler.dart';

@lazySingleton
class PermissionManager {
  // final NotificationManager notificationManager;
  final LocalNotificationManager localNotificationManager;
  // final SharedPrefsManager sharedPrefsManager;

  PermissionManager({
    // required this.notificationManager,
    required this.localNotificationManager,
    // required this.sharedPrefsManager,
  });

  // Future<bool> checkForPhotosPermissions(BuildContext context, {String title = generalPhotoTitle, String content = generalPhotoContent}) async {
  //   PermissionStatus permissionStatus;
  //   permissionStatus = await Permission.photos.request();

  //   if (permissionStatus == PermissionStatus.permanentlyDenied) {
  //     if (Platform.isAndroid) {
  //       showDialog(
  //         context: context,
  //         builder: (_) => AndroidPermissionDeniedDialog(
  //           title,
  //           content,
  //           _photosCancelText,
  //         ),
  //       );
  //     } else {
  //       showDialog(
  //         context: context,
  //         builder: (_) => IosPermissionDeniedDialog(
  //           title,
  //           content,
  //           _photosCancelText,
  //         ),
  //       );
  //     }
  //   }
  //   return (permissionStatus == PermissionStatus.granted || permissionStatus == PermissionStatus.limited);
  // }

  Future<void> checkForNotificationPermissions() async {
    PermissionStatus initialStatus = await Permission.notification.status;
    if (Platform.isAndroid) {
      if (initialStatus == PermissionStatus.granted) {
        // notificationManager.init();
      } else if (initialStatus == PermissionStatus.denied) {
        // _handleDeniedNotificationPermission(context, source, true);
      }
    } else {
      // iOS
      if (initialStatus == PermissionStatus.denied ||
          initialStatus == PermissionStatus.permanentlyDenied) {
        // _handleDeniedNotificationPermission(context, source, initialStatus == PermissionStatus.permanentlyDenied);
      } else if (initialStatus == PermissionStatus.granted) {
        // notificationManager.init();
        localNotificationManager.requestIosPermissions();
      }
    }
  }

  // void _handleDeniedNotificationPermission(BuildContext context, String source, bool openAppSettings) {
  //   int timesAsked = sharedPrefsManager.getLastNotificationPermissionRequestTimesAsked();
  //   DateTime? notificationDate = sharedPrefsManager.getLastNotificationPermissionRequestDate();
  //   DateTime now = DateTime.now();
  //   if (notificationDate == null || now.difference(notificationDate).inDays >= timesAsked) {
  //     showDialog(
  //       barrierDismissible: false,
  //       context: context,
  //       builder: (_) => NotificationPermissionPopup(openAppSettings: openAppSettings, source: source),
  //     );
  //     sharedPrefsManager.setLastNotificationPermissionRequestDate();
  //     sharedPrefsManager.setLastNotificationPermissionRequestTimesAsked();
  //   }
  // }
}
