import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/account/cubit/edit_profile_cubit.dart';
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
    _listenForUserUpdates();
    // _handleInitialNotificationMessages();
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
    return AutoTabsScaffold(
      // inheritNavigatorObservers: false,
      routes: [
        const HomeRoute(),
        const LikesRoute(),
        const NotificationsRoute(),
        const FavCardRoute(),
        const ChatsRoute(),
        AccountRoute(/*imageUrl: snapshot.data!.photoURL!, displayName: snapshot.data!.displayName!*/),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return FutureBuilder<User?>(
            future: futureUser,
            builder: (context, snapshot) {
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: BottomNavigationBar(
                  currentIndex: tabsRouter.activeIndex,
                  onTap: tabsRouter.setActiveIndex,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    const BottomNavigationBarItem(icon: Icon(Icons.home_outlined), activeIcon: Icon(Icons.home_filled), label: 'Home'),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.favorite_border_outlined),
                      activeIcon: Icon(Icons.favorite),
                      label: 'Likes',
                    ),
                    const BottomNavigationBarItem(
                        icon: Icon(Icons.notifications_outlined), activeIcon: Icon(Icons.notifications), label: 'Notification'),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset("assets/fav_card/fav_category/top.svg", color: Colors.black),
                        activeIcon: SvgPicture.asset("assets/fav_card/fav_category/top.svg"),
                        label: 'Fav Card'),
                    const BottomNavigationBarItem(
                      icon: Icon(Icons.chat_outlined),
                      activeIcon: Icon(Icons.chat),
                      label: 'Chat',
                    ),
                    BottomNavigationBarItem(
                      icon: BlocProvider<EditProfileCubit>.value(
                        value: getIt<EditProfileCubit>(),
                        child: BlocListener<EditProfileCubit, EditProfileState>(
                          listener: (context, state) {
                            if (state is EditProfileSuccessState) {
                              futureUser = Future(() => state.user);
                              // context.tabsRouter.setActiveIndex(4);
                              // setState(() {});
                            }
                          },
                          child: snapshot.connectionState != ConnectionState.done
                              ? CircularProgressIndicator()
                              : snapshot.data!.photoURL != null
                                  ? NativeHeadImage(
                                      // Image.asset("$_assetFolder/ic_test.png"),
                                      Image.network(snapshot.data!.photoURL!),
                                      borderColor: Theme.of(context).colorScheme.primary,
                                      radius: 14,
                                      borderRadius: 2,
                                      isGradientBorder: false,
                                    )
                                  : Placeholder(),
                        ),
                      ),
                      label: 'Account',
                    ),
                  ],
                  type: BottomNavigationBarType.fixed,
                ),
              );
            });
      },
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
        _notificationNavigator.navigateNotification(context: context, data: jsonDecode(_localNotificationManager.data.value!));
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

  void _listenForUserUpdates() {}
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // No-op
  LocalNotificationManager()
    ..init()
    ..showLocalNotification(message: message);
}
