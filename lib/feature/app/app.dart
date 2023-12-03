import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:logger/logger.dart';
import 'package:native/config.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/feature/auth/bloc/auth_cubit.dart';
import 'package:native/i18n/translations.g.dart';
import 'package:uni_links/uni_links.dart';

class App extends StatelessWidget {
  App({super.key});

  final AppRouter appRouter = getIt<AppRouter>();
  final Config config = getIt<Config>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, c) => p.theme != c.theme,
        builder: (context, state) {
          return GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: Center(
              child: CircularProgressIndicator(
                color: state.theme.light.primaryColor,
              ),
            ),
            overlayColor: const Color(0x3c1e1e1e),
            child: ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              // Use builder only if you need to use library outside ScreenUtilInit context
              builder: (_, child) {
                return MaterialApp.router(
                  /// Theme configuration.
                  theme: state.theme.light,
                  darkTheme:
                      state.theme.light, // TODO: need to support dark mode
                  themeMode: state.theme.mode,
                  title: t.strings.title,

                  /// Environment configuration.
                  debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,
                  debugShowMaterialGrid: config.debugShowMaterialGrid,

                  /// AutoRouter configuration.
                  // routerDelegate: appRouter.delegate(),
                  // routeInformationParser: appRouter.defaultRouteParser(),
                  routerConfig: appRouter.config(
                    navigatorObservers: () => [AutoRouteObserver()],
                  ),

                  /// EasyLocalization configuration.
                  locale: TranslationProvider.of(context).flutterLocale,
                  supportedLocales: AppLocaleUtils.supportedLocales,
                  localizationsDelegates: const [
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }
}

@RoutePage()
class AppWrapper extends StatefulWidget {
  const AppWrapper({super.key});

  @override
  State<AppWrapper> createState() => _AppWrapperState();
}

class _AppWrapperState extends State<AppWrapper> with WidgetsBindingObserver {
  final GlobalKey _key = GlobalKey();
  final _logger = getIt<Logger>();
  StreamSubscription? _sub;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    initUniLinks();
    Future.delayed(const Duration(milliseconds: 10),
        () => {context.read<AppCubit>().checkAuth()});
    // context.read<AppCubit>().changeStoryListType(type: StoryListType.best);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _handleLink(Uri uri) async {
    if (uri.hasQuery) {
      String? uid = uri.queryParameters['uid'];
      String? refId = uri.queryParameters['refId'];
      final appCubit = context.read<AppCubit>();
      if (uid != null) {
        final isEmailVerified = await appCubit.checkIfEmailVerifiedByUid(uid);
        if (isEmailVerified) {
          appCubit.logout(isVerifiedEmail: true);
        }
      } else if (refId != null) {
        final isEmailVerified =
            await appCubit.checkIfEmailVerifiedByRefId(refId);
        if (isEmailVerified) {
          appCubit.logout(isVerifiedEmail: true);
        }
      }
    }
  }

  Future<void> initUniLinks() async {
    try {
      // Check if you received the link via `getInitialLink` first
      final PendingDynamicLinkData? initialLink =
          await FirebaseDynamicLinks.instance.getInitialLink();

      if (initialLink != null) {
        final Uri deepLink = initialLink.link;
        _handleLink(deepLink);
      }

      FirebaseDynamicLinks.instance.onLink.listen(
        (pendingDynamicLinkData) {
          final Uri deepLink = pendingDynamicLinkData.link;
          _handleLink(deepLink);
        },
      );
      _sub = linkStream.listen((String? link) async {
        if (link != null) {
          final uri = Uri.parse(link);
          _handleLink(uri);
        }
      }, onError: (err) {
        // No-op
      });

      // Parse the link and warn the user, if it is not correct,
      // but keep in mind it could be `null`.
    } on PlatformException {
      // return?
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => context.read<AppCubit>(),
        child: BlocListener<AppCubit, AppState>(
          // listenWhen: (previous, current) => true,
          listener: (context, state) {
            FlutterNativeSplash.remove();
            // context.router.replace(const BasicDetailsRoute());
            if (state.authResult != null) {
              // if (!(state.authResult!.user.emailVerified ?? false)) {
              //   context.router.replace(const BasicDetailsRoute());
              // } else
              if (state.loggedOut == true) {
                context.router.replaceAll(
                    [SignInRoute(isVerifiedEmail: state.hasVerifiedEmail)]);
              } else if (state.authResult!.user.customClaims?.birthday ==
                  null) {
                context.router.replace(const BasicDetailsRoute());
              } else if (!state.hasCompletedTutorial) {
                context.router.replace(NativeCardScaffold(
                    user: state.authResult!.user, showNext: true));
                // context.router.replace(const HomeWrapperRoute());
              } else {
                // context.router.replace(const BasicDetailsRoute());
                context.router.replace(const HomeWrapperRoute());
              }
            } else {
              (state.hasSkippedOnboarding == false)
                  ? context.router.replace(OnboardingRoute(),
                      onFailure: (failure) => _logger.d(failure.toString()))
                  // : context.router.replace(const HomeWrapperRoute());
                  : context.router.replaceAll(
                      [SignInRoute(isVerifiedEmail: state.hasVerifiedEmail)],
                      onFailure: (failure) => _logger.d(failure.toString()));
            }
          },
          child: RepaintBoundary(
            key: _key,
            child: const AutoRouter(),
          ),
        ));
  }
}
