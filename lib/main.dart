import 'dart:async';

import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:native/config.dart';
import 'package:native/di/di.dart';
import 'package:native/firebase_options.dart';
import 'package:native/i18n/translations.g.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:universal_platform/universal_platform.dart';

import 'feature/app/app.dart';

Future<void> main() async {
  // FlutterError.onError = (FlutterErrorDetails details) async {
  //   if (kDebugMode) {
  //     // In development mode simply print to console.
  //     FlutterError.dumpErrorToConsole(details);

  //   } else {
  //     // In production mode report to the application zone to report to
  //     // app exceptions provider. We do not need this in Profile mode.
  //     // ignore: no-empty-block
  //     if (kReleaseMode) {
  //       // FlutterError class has something not changed as far as null safety
  //       // so I just assume we do not have a stack trace but still want the
  //       // detail of the exception.
  //       // ignore: cast_nullable_to_non_nullable
  //       Zone.current.handleUncaughtError(
  //         // ignore: cast_nullable_to_non_nullable
  //         details.exception,
  //         // ignore: cast_nullable_to_non_nullable
  //         details.stack as StackTrace,
  //       );
  //     }
  //   }
  // };

  await runZonedGuarded<Future<void>>(
    () async {
      final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
      FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

      // Use device locale.
      LocaleSettings.useDeviceLocale();

      // Configures dependency injection to init modules and singletons.
      await configureDi();
      final logger = getIt<Logger>();
      logger.d("DI has been configured");
      final Config config = getIt<Config>();
      logger.d("Config flavor ${config.flavor}");

      // Initial Firebase
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform(config),
      );
      await FirebaseAppCheck.instance.activate(
        androidProvider: kReleaseMode
            ? AndroidProvider.playIntegrity
            : AndroidProvider.debug,
        appleProvider:
            kReleaseMode ? AppleProvider.deviceCheck : AppleProvider.debug,
      );
      FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

      FlutterError.onError = (errorDetails) {
        FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
      };
      // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
      PlatformDispatcher.instance.onError = (error, stack) {
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
        return true;
      };

      if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
        // Sets up allowed device orientations and other settings for the app.
        await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
        );
      }

      // This setting smoothes transition color for LinearGradient.
      Paint.enableDithering = true;

      // Set hydrated bloc storage.
      HydratedBloc.storage = await HydratedStorage.build(
        storageDirectory: UniversalPlatform.isWeb
            ? HydratedStorage.webStorageDirectory
            : await getApplicationDocumentsDirectory(),
      );

      return runApp(TranslationProvider(child: App()));
    },
    (exception, stackTrace) async {
      getIt<Logger>().e("Unexpected error", exception, stackTrace);
      FirebaseCrashlytics.instance.recordError(exception, stackTrace);
    },
  );
}
