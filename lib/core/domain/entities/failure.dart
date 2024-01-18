import 'dart:async';

import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'failure.freezed.dart';

@freezed
sealed class Failure with _$Failure {
  const Failure._();

  const factory Failure.unknownFailure({
    required String message,
  }) = UnknownFailure;

  const factory Failure.unauthorized({
    required String message,
  }) = UnauthorizedFailure;

  const factory Failure.timeout({
    required String message,
  }) = TimeoutFailure;

  const factory Failure.serverFailure({
    required String message,
  }) = ServerFailure;

  const factory Failure.badRequest({
    required String message,
  }) = BadRequestFailure;

  factory Failure.fromException(Object exception) {
    if (exception is DioException) {
      return remoteFailureMapper(exception);
    }
    if (exception is TimeoutException) {
      return TimeoutFailure(
        message: exception.message ?? 'UnexpectedTimeoutFailure',
      );
    }
    return UnknownFailure(message: exception.toString());
  }
}

Failure remoteFailureMapper(DioException dioException) {
  final statusCode = dioException.response?.statusCode;
  switch (dioException.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.connectionError:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return TimeoutFailure(message: dioException.message ?? 'TimeoutFailure');
    case DioExceptionType.badResponse:
      return _statusCodeMapper(
        statusCode,
        dioException.message ?? 'BadResponseFailure',
      );
    case DioExceptionType.cancel:
    case DioExceptionType.badCertificate:
    case DioExceptionType.unknown:
      return UnknownFailure(message: dioException.message ?? 'UnknownFailure');
  }
}

Failure _statusCodeMapper(int? statusCode, String message) {
  if (statusCode != null) {
    if (statusCode == 401) {
      return UnauthorizedFailure(message: message);
    }
    if (statusCode >= 400 && statusCode <= 499) {
      return BadRequestFailure(message: message);
    }
    if (statusCode >= 500 && statusCode <= 599) {
      return ServerFailure(message: message);
    }
  }
  return UnknownFailure(message: message);
}
