import 'dart:convert';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
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
import 'package:native/theme/theme.dart';
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

  _updateSystemUi() {
    updateSystemUi(context, Theme.of(context).colorScheme.primaryContainer, Theme.of(context).colorScheme.primaryContainer);
  }

  final _labelList = const <String>['Home', 'Likes', 'Notification', 'FavCard', 'Chat', 'Account'];

  @override
  Widget build(BuildContext context) {
    _updateSystemUi();
    return AutoTabsScaffold(
      // inheritNavigatorObservers: false,
      routes: const [
        HomeRoute(),
        LikesRoute(),
        NotificationsRoute(),
        FavCardRoute(),
        ChatsRoute(),
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
                  onTap: (idx) {
                    FirebaseAnalytics.instance.logScreenView(screenName: _labelList[idx]);
                    tabsRouter.setActiveIndex(idx);
                  },
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.home_outlined), activeIcon: const Icon(Icons.home_filled), label: _labelList[0]),
                    BottomNavigationBarItem(
                      icon: const Icon(Icons.favorite_border_outlined),
                      activeIcon: const Icon(Icons.favorite),
                      label: _labelList[1],
                    ),
                    BottomNavigationBarItem(
                        icon: const Icon(Icons.notifications_outlined), activeIcon: const Icon(Icons.notifications), label: _labelList[2]),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset(
                          "assets/fav_card/fav_card.svg",
                          color: Colors.black,
                          height: 26,
                          width: 26,
                        ),
                        activeIcon: SvgPicture.asset(
                          "assets/fav_card/fav_card_filled.svg",
                          height: 26,
                          width: 26,
                        ),
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
                              ? const CircularProgressIndicator()
                              : snapshot.data!.photoURL != null
                                  ? NativeHeadImage(
                                      // Image.asset("$_assetFolder/ic_test.png"),
                                      Image.network(snapshot.data!.photoURL!),
                                      borderColor: Theme.of(context).colorScheme.primary,
                                      radius: 14,
                                      borderRadius: 2,
                                      isGradientBorder: false,
                                    )
                                  : const Placeholder(),
                        ),
                      ),
                      label: _labelList[5],
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
