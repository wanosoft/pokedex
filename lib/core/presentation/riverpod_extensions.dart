import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'error_handler.dart';

typedef ErrorHandlerBuilder = Widget Function(
  Object error,
  StackTrace? stackTrace,
);

extension AsyncValueExtension<T> on AsyncValue<T> {
  /// Returns a [Widget] based on the state of the [AsyncValue].
  ///
  /// It contains a default handler for error, and loading states.
  Widget renderWhen(
    Widget Function(T data) data, {
    VoidCallback? onRetry,
    ErrorHandlerBuilder? error,
    Widget Function()? loading,
    bool skipLoadingOnRefresh = true,
    bool skipLoadingOnReload = false,
    bool sliver = false,
  }) {
    if (error == null) {
      assert(
        onRetry != null,
        'default error handler requires not null onRetry callback',
      );
    }

    return when<Widget>(
      data: data,
      error: (e, stackTrace) {
        log(
          e.toString(),
          error: e,
          stackTrace: stackTrace,
        );
        if (error != null) return error(e, stackTrace);
        final widget = errorHandler(
          e,
          stackTrace,
          onRetry: onRetry!,
        );

        if (sliver) return SliverFillRemaining(child: widget);
        return widget;
      },
      loading: () {
        const widget = Center(child: CircularProgressIndicator());
        if (loading != null) return loading();
        if (sliver) return const SliverFillRemaining(child: widget);
        return widget;
      },
      skipLoadingOnRefresh: skipLoadingOnRefresh,
      skipLoadingOnReload: skipLoadingOnReload,
    );
  }

  /// Switch-case over the state of the [AsyncValue] while purposefully not handling
  /// some cases.
  ///
  /// If [AsyncValue] was in a case that is not handled, will return [orElse].
  Widget? renderOrElse({
    Widget? Function(AsyncData<T> data)? data,
    Widget? Function(AsyncError<T> error)? error,
    Widget? Function(AsyncLoading<T> loading)? loading,
    required Widget? Function() orElse,
  }) =>
      maybeMap<Widget?>(
        data: data,
        error: error,
        loading: loading,
        orElse: orElse,
      );
}
