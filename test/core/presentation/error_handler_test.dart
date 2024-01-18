import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/presentation/error_handler.dart';

import '../../test_utils/mocks.dart';
import '../../test_utils/test_widgets_utils.dart';

void main() {
  group('error handler', () {
    late VoidCallBack onRetry;
    late Object error;

    setUp(() {
      onRetry = MockVoidCallBack();
    });

    testWidgets('should map error and return an error widget', (tester) async {
      error = TimeoutException('message');

      await prepareAndSettle(
        tester,
        widget: errorHandler(error, null, onRetry: onRetry.call),
      );

      expect(find.byType(PokedexErrorWidget), findsOneWidget);
      expect(find.text('message'), findsOneWidget);

      final buttonFinder = find.byIcon(Icons.refresh);
      expect(buttonFinder, findsOneWidget);

      await tester.tap(buttonFinder);
      await tester.pump();

      verify(() => onRetry()).called(1);
      verifyNoMoreInteractions(onRetry);
    });
  });
}
