import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/presentation/error_handler.dart';
import 'package:pokedex/core/presentation/riverpod_extensions.dart';

import '../../test_utils/mocks.dart';
import '../../test_utils/test_widgets_utils.dart';

void main() {
  group('riverpod extensions', () {
    group('render when', () {
      late VoidCallBack onRetry;

      setUp(() => onRetry = MockVoidCallBack());

      testWidgets('should return a text widget', (tester) async {
        const text = 'text';
        const value = AsyncData(text);

        await prepareAndSettle(
          tester,
          widget: value.renderWhen((data) => Text(data), onRetry: onRetry.call),
        );

        expect(find.text(text), findsOneWidget);
        verifyZeroInteractions(onRetry);
      });

      testWidgets('should return the default error widget', (tester) async {
        final exception = DioException(
          requestOptions: RequestOptions(path: 'path'),
          response: Response(
            requestOptions: RequestOptions(path: 'path'),
            statusCode: 404,
          ),
        );
        final value = AsyncError(exception, StackTrace.empty);

        await prepareAndSettle(
          tester,
          widget: value.renderWhen((data) => Text(data), onRetry: onRetry.call),
        );

        expect(find.byType(PokedexErrorWidget), findsOneWidget);

        await tester.tap(find.byIcon(Icons.refresh));
        await tester.pump();

        verify(() => onRetry()).called(1);
        verifyNoMoreInteractions(onRetry);
      });

      testWidgets('should return custom error widget', (tester) async {
        final exception = DioException(
          requestOptions: RequestOptions(path: 'path'),
          response: Response(
            requestOptions: RequestOptions(path: 'path'),
            statusCode: 404,
          ),
        );
        final value = AsyncError(exception, StackTrace.empty);

        await prepareAndSettle(
          tester,
          widget: value.renderWhen(
            (data) => Text(data),
            error: (_, __) => const Icon(Icons.star),
          ),
        );

        expect(find.byType(PokedexErrorWidget), findsNothing);
        expect(find.byIcon(Icons.star), findsOneWidget);

        verifyZeroInteractions(onRetry);
      });

      testWidgets('should return default loading widget', (tester) async {
        const value = AsyncLoading<String>();

        await pumpWidget(
          tester,
          widget: value.renderWhen((data) => Text(data), onRetry: onRetry.call),
        );
        await tester.pump();

        expect(find.byType(PokedexErrorWidget), findsNothing);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        verifyZeroInteractions(onRetry);
      });

      testWidgets('should return custom loading widget', (tester) async {
        const loadingLabel = 'Loading...';
        const value = AsyncLoading<String>();

        await prepareAndSettle(
          tester,
          widget: value.renderWhen(
            (data) => Text(data),
            error: (_, __) => const Icon(Icons.star),
            loading: () => const Text(loadingLabel),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.text(loadingLabel), findsOneWidget);

        verifyZeroInteractions(onRetry);
      });
    });
  });
}
