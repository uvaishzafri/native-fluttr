import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/repo/user_repository.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends $AppRouter {
  @override
  final List<AutoRoute> routes = [
    CustomRoute(
      path: '/',
      page: AppWrapper.page,
      initial: true,
      transitionsBuilder: TransitionsBuilders.fadeIn,
      durationInMilliseconds: 240,
      children: [
        FadeCustomRoute(page: OnboardingRoute.page),
        FadeCustomRoute(page: SignInRoute.page),
        FadeCustomRoute(page: SignUpRoute.page),
        FadeCustomRoute(page: BasicDetailsRoute.page),
        FadeCustomRoute(page: PhotoUploadRoute.page),
        FadeCustomRoute(page: PhotoRoute.page),
        FadeCustomRoute(page: OtherDetailsRoute.page),
        FadeCustomRoute(page: BasicPrefrencesRoute.page),
        FadeCustomRoute(page: OtherPreferencesRoute.page),
        FadeCustomRoute(page: GenerateNativeCardRoute.page),
        FadeCustomRoute(page: EditProfileRoute.page),
        FadeCustomRoute(page: NotificationSettingsRoute.page),
        FadeCustomRoute(page: SocialAccountSettingsRoute.page),
        FadeCustomRoute(page: AccountPlansRoute.page),
        FadeCustomRoute(page: NativeCardDetailsRoute.page),
        FadeCustomRoute(page: NativeCardScaffold.page),
        FadeCustomRoute(page: HowToChoosePartnerLoaderRoute.page),
        FadeCustomRoute(page: ChoosePartnerRoute.page),
        FadeCustomRoute(page: ChatMessagesRoute.page),
        FadeCustomRoute(page: NotificationsRoute.page),
        FadeCustomRoute(page: LikesRoute.page),
        CustomRoute(
          path: 'home',
          page: HomeWrapperRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 240,
          children: [
            FadeCustomRoute(page: HomeRoute.page),
            FadeCustomRoute(page: LikesRoute.page),
            FadeCustomRoute(page: NotificationsRoute.page),
            FadeCustomRoute(page: AccountRoute.page),
            FadeCustomRoute(page: ChatsRoute.page),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ];
}

class FadeCustomRoute extends CustomRoute {
  FadeCustomRoute(
      {required super.page, super.transitionsBuilder = TransitionsBuilders.fadeIn, super.durationInMilliseconds = 240});
}

// class MyObserver extends AutoRouterObserver {
//   @override
//   void didPush(Route route, Route? previousRoute) {
//     print('New route pushed: ${route.settings.name}');
//   }

//   // only override to observer tab routes
//   @override
//   void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
//     print('Tab route visited: ${route.name}');
//   }

//   @override
//   void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
//     print('Tab route re-visited: ${route.name}');
//   }

//   @override
//   void didPop(Route route, Route? previousRoute) {
//     // print('new route poped');
//     // print((previousRoute!.settings as AutoRoutePage).routeData.router.currentPath);
//     if ((previousRoute!.settings as AutoRoutePage).routeData.router.currentPath == '/home/home-route') {
//       var context = previousRoute.navigator!.overlay!.context;
//       showDialog(
//         context: context,
//         builder: (context) => SimpleDialog(
//           title: Text('simple dialog'),
//         ),
//       );
//       // final userRepo = getIt<UserRepository>();
//       // userRepo.getMatches().then((value) => value.fold((left) => null, (right) {
//       //   var context = previousRoute.navigator!.overlay!.context;
//       //   return showDialog(context: context, builder: (context) => SimpleDialog(title: Text('simple dialog'),),);
//       // }));
//     }
//   }
// }
