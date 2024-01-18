import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'remote_config.g.dart';

@Riverpod(keepAlive: true)
Dio dio(DioRef ref) {
  return RemoteConfig.buildDioClient();
}

class RemoteConfig {
  const RemoteConfig._();

  static const baseUrl = 'https://pokeapi.co/api/v2';

  static Dio buildDioClient() {
    final dio = Dio();
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(
      PrettyDioLogger(
        logPrint: (object) => log(object.toString()),
      ),
    );
    return dio;
  }
}
