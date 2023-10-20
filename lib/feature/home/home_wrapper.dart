import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/manager/notification_manager/local_notification_manager.dart';
import 'package:native/manager/notification_manager/notification_manager.dart';
import 'package:native/manager/notification_manager/notification_navigator.dart';
import 'package:native/manager/permission_manager/permission_manager.dart';
import 'package:native/model/user.dart';
import 'package:native/widget/images.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _assetFolder = 'assets/home';

@RoutePage()
class HomeWrapperScreen extends StatefulWidget {
  const HomeWrapperScreen({Key? key}) : super(key: key);
  @override
  State<HomeWrapperScreen> createState() => _HomeWrapperScreenState();
}

class _HomeWrapperScreenState extends State<HomeWrapperScreen> {
  late final PermissionManager _permissionManager;
  late final LocalNotificationManager _localNotificationManager;
  late final NotificationManager _notificationManager;
  late final NotificationNavigator _notificationNavigator;
  late Future<User?> futureUser;

  @override
  void initState() {
    super.initState();
    _permissionManager = getIt<PermissionManager>();
    _localNotificationManager = getIt<LocalNotificationManager>()..init();
    _notificationManager = getIt<NotificationManager>();
    _notificationNavigator = getIt<NotificationNavigator>();
    _listenForNotificationPermissions();
    _listenForLocalNotifications();
    _registerNotificationCallbacks();
    _handleInitialNotificationMessages();
    futureUser = getStoredUser();
  }

  Future<User?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson == null) {
      return null;
    }
    return User.fromJson(jsonDecode(userJson));
  }
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
        future: futureUser,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          return AutoTabsScaffold(
            routes: [
              HomeRoute(),
              LikesRoute(),
              NotificationsRoute(),
              ChatsRoute(),
              AccountRoute(imageUrl: snapshot.data!.photoURL!, displayName: snapshot.data!.displayName!),
            ],
            bottomNavigationBuilder: (_, tabsRouter) {
              return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: BottomNavigationBar(
                    currentIndex: tabsRouter.activeIndex,
                    onTap: tabsRouter.setActiveIndex,
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    items: <BottomNavigationBarItem>[
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_filled), label: 'Home'),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.favorite_border_outlined),
                        activeIcon: Icon(Icons.favorite),
                        label: 'Likes',
                      ),
                      const BottomNavigationBarItem(
                          icon: Icon(Icons.notifications_outlined),
                          activeIcon: Icon(Icons.notifications),
                          label: 'Notification'),
                      const BottomNavigationBarItem(
                        icon: Icon(Icons.chat_outlined),
                        activeIcon: Icon(Icons.chat),
                        label: 'Chat',
                      ),
                      BottomNavigationBarItem(
                        icon: NativeHeadImage(
                          // Image.asset("$_assetFolder/ic_test.png"),
                          Image.network(snapshot.data!.photoURL!),
                          borderColor: Theme.of(context).colorScheme.primary,
                          radius: 14,
                          borderRadius: 2,
                          isGradientBorder: false,
                        ),
                        label: 'Account',
                      ),
                    ],
                    type: BottomNavigationBarType.fixed,
                  ));
            },
          );
        }
    );
  }

  void _listenForNotificationPermissions() {
    if (Platform.isAndroid) {
      _permissionManager.checkForNotificationPermissions();
    }
  }

  void _listenForLocalNotifications() {
    _localNotificationManager.data.addListener(() {
      if (_localNotificationManager.data.value != null) {
        _notificationNavigator.navigateNotification(
            context: context, data: jsonDecode(_localNotificationManager.data.value!));
      }
    });
  }

  void _registerNotificationCallbacks() {
    _notificationManager.setBackgroundMessageCallback(_firebaseMessagingBackgroundHandler);
    _notificationManager.setForegroundMessageCallback((RemoteMessage message) {
      _localNotificationManager.showLocalNotification(message: message);
    });
    _notificationManager.setBackgroundMessageOpenedCallback((RemoteMessage message) {
      _notificationNavigator.navigateNotification(
        context: context,
        data: message.data,
      );
    });
  }

  Future<void> _handleInitialNotificationMessages() async {
    RemoteMessage? message = await FirebaseMessaging.instance.getInitialMessage();
    if (message != null) {
      _notificationNavigator.navigateNotification(context: context, data: message.data);
    }

    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await _localNotificationManager.getNotificationAppLaunchDetails();
    if (notificationAppLaunchDetails != null &&
        notificationAppLaunchDetails.notificationResponse?.payload != null &&
        notificationAppLaunchDetails.notificationResponse!.payload!.isNotEmpty) {
      _notificationNavigator.navigateNotification(
        context: context,
        data: jsonDecode(notificationAppLaunchDetails.notificationResponse!.payload!),
      );
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // No-op
}
