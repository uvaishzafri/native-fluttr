import 'package:get_it/get_it.dart';
import 'package:native/di/di.config.dart';
import 'package:injectable/injectable.dart';

final GetIt getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDi() async => getIt.init();
