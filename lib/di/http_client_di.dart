import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:native/config.dart';
import 'package:injectable/injectable.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:universal_platform/universal_platform.dart';

@module
abstract class HttpClientModule {
  Dio dio(Config config) => _initDioClient(config);
}

Dio _initDioClient(Config config) {
  final dio = Dio();

  if (UniversalPlatform.isAndroid || UniversalPlatform.isIOS) {
    /// Allows https requests for older devices.
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      return client;
    };
  }

  dio.options.baseUrl = config.nativeBaseUrl;
  dio.options.headers['Accept-Language'] = Platform.localeName.substring(0, 2);
  dio.options.connectTimeout = Duration(milliseconds: config.httpClientTimeout);
  dio.options.receiveTimeout = Duration(milliseconds: config.httpClientTimeout);
  dio.options.sendTimeout = Duration(milliseconds: config.httpClientTimeout);

  if (config.isDebug) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ),
    );
  }

  return dio;
}
