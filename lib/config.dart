import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

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
    required String hacknewsBaseUrl,
    required bool debugShowCheckedModeBanner,
    required bool debugShowMaterialGrid,
    required String tenantId,
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
    final hacknewsBaseUrl = dotenv.env['HK_BASE_URL'] ?? '';

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

    final tenandId = dotenv.env['AUTH_TENANT_ID'] ?? '';

    return Config(
      build: build,
      flavor: flavor,
      httpClientTimeout: httpClientTimeout,
      hacknewsBaseUrl: hacknewsBaseUrl,
      debugShowCheckedModeBanner: build == Build.debug,
      debugShowMaterialGrid: false,
      tenantId: tenandId,
    );
  }

  bool get isDebug => build == Build.debug;
  bool get isRelease => build == Build.release;
}
