import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/domain/entities/failure.dart';

import '../../../test_utils/model_factory.dart';

void main() {
  group('failure from exception mapper', () {
    group('should factory timeout failure', () {
      final timeoutDioExceptions = [
        createDioException(type: DioExceptionType.connectionTimeout),
        createDioException(type: DioExceptionType.connectionError),
        createDioException(type: DioExceptionType.sendTimeout),
        createDioException(type: DioExceptionType.receiveTimeout),
      ];

      for (final dioException in timeoutDioExceptions) {
        test('when dio exception type is ${dioException.type}', () {
          final failure = Failure.fromException(dioException);

          expect(failure, isA<TimeoutFailure>());
        });
      }
    });

    group('should factory unknown failure', () {
      final unknownDioExceptions = [
        createDioException(type: DioExceptionType.cancel),
        createDioException(type: DioExceptionType.badCertificate),
        createDioException(type: DioExceptionType.unknown),
      ];

      for (final dioException in unknownDioExceptions) {
        test('when dio exception type is ${dioException.type}', () {
          final failure = Failure.fromException(dioException);

          expect(failure, isA<UnknownFailure>());
        });
      }
    });

    group('on bad response failures', () {
      test('should factory unautorized failure', () {
        final dioException = createDioException(
          type: DioExceptionType.badResponse,
          statusCode: 401,
        );

        final failure = Failure.fromException(dioException);

        expect(failure, isA<UnauthorizedFailure>());
      });

      test('should factory bad request failure', () {
        final dioException = createDioException(
          type: DioExceptionType.badResponse,
          statusCode: 400,
        );

        final failure = Failure.fromException(dioException);

        expect(failure, isA<BadRequestFailure>());
      });

      test('should factory server failure', () {
        final dioException = createDioException(
          type: DioExceptionType.badResponse,
          statusCode: 500,
        );

        final failure = Failure.fromException(dioException);

        expect(failure, isA<ServerFailure>());
      });
    });
  });
}
