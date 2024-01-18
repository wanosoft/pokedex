import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/data/remote_config.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

void main() {
  group('remote config', () {
    test('should build dio client', () {
      final dio = RemoteConfig.buildDioClient();

      expect(dio.options.baseUrl, RemoteConfig.baseUrl);
      expect(
        dio.interceptors,
        isA<List<Interceptor>>().having(
          (p0) => p0[1],
          'PrettyDioLogger',
          isA<PrettyDioLogger>(),
        ),
      );
    });
  });
}
