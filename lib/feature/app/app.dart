import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:native/config.dart';
import 'package:native/di/di.dart';
import 'package:native/feature/app/app_router.dart';
import 'package:native/feature/app/app_router.gr.dart';
import 'package:native/feature/app/bloc/app_cubit.dart';
import 'package:native/i18n/translations.g.dart';

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<AppCubit>(),
      child: BlocBuilder<AppCubit, AppState>(
        buildWhen: (p, c) => p.theme != c.theme,
        builder: (context, state) {
          final AppRouter appRouter = getIt<AppRouter>();
          final Config config = getIt<Config>();
          return GlobalLoaderOverlay(
              useDefaultLoading: false,
              overlayWidget: Center(
                child: CircularProgressIndicator(
                  color: state.theme.light.primaryColor,
                ),
              ),
              overlayColor: const Color(0x3c1e1e1e),
              child: MaterialApp.router(
                /// Theme configuration.
                theme: state.theme.light,
                darkTheme: state.theme.dark,
                themeMode: state.theme.mode,
                title: t.strings.title,

                /// Environment configuration.
                debugShowCheckedModeBanner: config.debugShowCheckedModeBanner,
                debugShowMaterialGrid: config.debugShowMaterialGrid,

                /// AutoRouter configuration.
                routerDelegate: appRouter.delegate(),
                routeInformationParser: appRouter.defaultRouteParser(),

                /// EasyLocalization configuration.
                locale: TranslationProvider.of(context).flutterLocale,
                supportedLocales: AppLocaleUtils.supportedLocales,
                localizationsDelegates: const [
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
              ));
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

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    Future.delayed(const Duration(milliseconds: 10),
        () => {context.read<AppCubit>().checkAuth()});
    // context.read<AppCubit>().changeStoryListType(type: StoryListType.best);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => context.read<AppCubit>(),
        child: BlocListener<AppCubit, AppState>(
          listener: (context, state) {
            FlutterNativeSplash.remove();

            (state.hasSkippedOnboarding == false)
                ? context.router.replace(OnboardingRoute())
                : context.router.replace(const HomeWrapperRoute());
            // if (state.type == StoryListType.top) {
            //   context.replaceRoute(const TopStoryRoute());
            // } else if (state.type == StoryListType.best) {
            //   context.replaceRoute(const BestStoryRoute());
            // }
          },
          child: RepaintBoundary(
            key: _key,
            child: const AutoRouter(),
          ),
        ));
  }
}
