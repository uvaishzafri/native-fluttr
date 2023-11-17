import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:native/util/exceptions.dart';

part 'config.freezed.dart';
part 'config.g.dart';

enum Build { debug, release }

enum Flavor { stg, prod }

const String _defaultTimeout = '10000';

@freezed
@singleton
@preResolve
class Config with _$Config {
  factory Config({
    required Build build,
    required Flavor flavor,
    required int httpClientTimeout,
    required String nativeBaseUrl,
    required bool debugShowCheckedModeBanner,
    required bool debugShowMaterialGrid,
    required String verifyEmailRedirectUrl,
    required String firebaseProjectId,
    required String firebaseStorageBucket,
    required String firebaseMessagingSenderId,
    required String firebaseAndroidApiKey,
    required String firebaseAndroidAppId,
    required String firebaseIosBundleId,
    required String firebaseIosApiKey,
    required String firebaseIosAppId,
    required int refreshTokenDurationInSeconds,
    required String termsAndConditionsUrl,
    required String privacyPolicyUrl,
    required String nativePricingUrl,
  }) = _Config;

  Config._();

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);

  @factoryMethod
  static Future<Config> create() async {
    const build =
        bool.fromEnvironment('dart.vm.product') ? Build.release : Build.debug;
    final flavor = EnumToString.fromString(
            Flavor.values, const String.fromEnvironment('FLAVOR')) ??
        Flavor.stg;

    final envFile = flavor == Flavor.stg ? ".env.stg" : ".env.prod";
    await dotenv.load(fileName: envFile);

    final timeoutStr = dotenv.env['HTTP_CLIENT_TIMEOUT'] ?? _defaultTimeout;
    final httpClientTimeout =
        int.parse(timeoutStr.isNotEmpty ? timeoutStr : _defaultTimeout);
    final nativeBaseUrl = dotenv.env['NATIVE_BASE_URL'] ?? '';

    final verifyEmailRedirectUrl = dotenv.env['VERIFY_EMAIL_REDIRECT_URL'];
    throwIf(verifyEmailRedirectUrl == null,
        MissingRequiredConfigException("Missing VERIFY_EMAIL_REDIRECT_URL"));

    final firebaseProjectId = dotenv.env['FIREBASE_PROJECT_ID'] ?? '';
    final firebaseStorageBucket = dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';
    final firebaseMessagningSenderId =
        dotenv.env['FIREBASE_MESSAGING_SENDER_ID'] ?? '';
    final firebaseAndroidApiKey = dotenv.env['FIREBASE_ANDROID_API_KEY'] ?? '';
    final firebaseAndroidAppId = dotenv.env['FIREBASE_ANDROID_APP_ID'] ?? '';
    final firebaseIosBundleId = dotenv.env['FIREBASE_IOS_BUNDLE_ID'] ?? '';
    final firebaseIosApiKey = dotenv.env['FIREBASE_IOS_API_KEY'] ?? '';
    final firebaseIosAppId = dotenv.env['FIREBASE_IOS_APP_ID'] ?? '';
    final refreshTokenDurationInSeconds = int.parse(
        dotenv.env['REFRESH_TOKEN_DURATION'] ?? '1209600'); // Default 14 days

    final termsAndConditionsUrl = dotenv.env['TERMS_CONDITIONS_URL'] ?? '';
    final privacyPolicyUrl = dotenv.env['PRIVACY_POLICY_URL'] ?? '';
    final nativePricingUrl = dotenv.env['NATIVE_PRICING_URL'] ?? '';

    final logLevelStr = dotenv.env['LOG_LEVEL'] ?? 'WARM';
    switch (logLevelStr) {
      case 'ERROR':
        Logger.level = Level.error;
        break;
      case 'WARM':
        Logger.level = Level.warning;
        break;
      case 'INFO':
        Logger.level = Level.info;
        break;
      case 'DEBUG':
        Logger.level = Level.debug;
        break;
      case 'VERBOSE':
        Logger.level = Level.verbose;
        break;
      default:
        Logger.level = Level.warning;
        break;
    }

    return Config(
      build: build,
      flavor: flavor,
      httpClientTimeout: httpClientTimeout,
      nativeBaseUrl: nativeBaseUrl,
      debugShowCheckedModeBanner: false,
      // debugShowCheckedModeBanner: build == Build.debug,
      debugShowMaterialGrid: false,
      verifyEmailRedirectUrl: verifyEmailRedirectUrl!,
      firebaseProjectId: firebaseProjectId,
      firebaseStorageBucket: firebaseStorageBucket,
      firebaseMessagingSenderId: firebaseMessagningSenderId,
      firebaseAndroidApiKey: firebaseAndroidApiKey,
      firebaseAndroidAppId: firebaseAndroidAppId,
      firebaseIosBundleId: firebaseIosBundleId,
      firebaseIosApiKey: firebaseIosApiKey,
      firebaseIosAppId: firebaseIosAppId,
      refreshTokenDurationInSeconds: refreshTokenDurationInSeconds,
      termsAndConditionsUrl: termsAndConditionsUrl,
      privacyPolicyUrl: privacyPolicyUrl,
      nativePricingUrl: nativePricingUrl,
    );
  }

  bool get isDebug => build == Build.debug;
  bool get isRelease => build == Build.release;
}
