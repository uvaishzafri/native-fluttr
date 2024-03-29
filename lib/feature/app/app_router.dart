import 'package:auto_route/auto_route.dart';
import 'package:native/feature/app/app_router.gr.dart';

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
        CustomRoute(
          path: 'home',
          page: HomeWrapperRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
          durationInMilliseconds: 240,
          children: [
            FadeCustomRoute(page: HomeRoute.page),
            FadeCustomRoute(page: OnboardingRoute.page),
            FadeCustomRoute(page: SignInRoute.page),
            FadeCustomRoute(page: SignUpRoute.page),
          ],
        ),
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
  ];
}

class FadeCustomRoute extends CustomRoute {
  FadeCustomRoute(
      {required super.page,
      super.transitionsBuilder = TransitionsBuilders.fadeIn,
      super.durationInMilliseconds = 240});
}
