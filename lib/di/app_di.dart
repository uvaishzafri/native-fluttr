import 'package:native/feature/app/app_router.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class AppModule {
  Logger get logger => Logger();
  AppRouter router() => AppRouter();
}
