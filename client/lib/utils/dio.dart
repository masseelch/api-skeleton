import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';

import '../config.dart';

Dio newDio(Config config) {
  assert(config != null);

  final dio = Dio();

  dio.options.baseUrl = config.baseUrl;

  // Use json as message format. // todo - protobuf
  dio.options.headers[Headers.acceptHeader] = 'application/json';
  dio.transformer = FlutterTransformer();

  // Interceptor to log the requests made.
  // Add it to the end of the queue so its gets every change made in the
  // interceptor chain.
  if (config.isDev) {
    dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  return dio;
}
