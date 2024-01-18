import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

const screenWidth = 1170.0;
const screenHeight = 2532.0;
const defaultScreenSize = Size(screenWidth, screenHeight);

class MockGoRouter extends Mock implements GoRouter {}

class ConsumerBuilderWrapper extends ConsumerWidget {
  const ConsumerBuilderWrapper(
    this.builder, {
    super.key,
  });
  final Widget Function(BuildContext, WidgetRef) builder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return builder(context, ref);
  }
}

class ProviderScopeWrapper extends StatelessWidget {
  const ProviderScopeWrapper({
    this.isConsumer = false,
    this.overrides = const [],
    required this.widget,
    super.key,
  });

  final bool isConsumer;
  final List<Override> overrides;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return isConsumer
        ? ProviderScope(
            overrides: overrides,
            child: widget,
          )
        : widget;
  }
}

class NavigationWrapper extends StatelessWidget {
  const NavigationWrapper({
    this.mockGoRouter,
    required this.widget,
    super.key,
  });

  bool get supportNavigation => mockGoRouter != null;
  final GoRouter? mockGoRouter;
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return supportNavigation
        ? InheritedGoRouter(
            goRouter: mockGoRouter!,
            child: widget,
          )
        : widget;
  }
}

Future<void> prepareAndSettle(
  WidgetTester tester, {
  required Widget widget,
  Size screenSize = defaultScreenSize,
  bool isConsumer = false,
  GoRouter? goRouter,
  List<Override> overrides = const [],
}) async {
  await pumpWidget(
    tester,
    screenSize: screenSize,
    isConsumer: isConsumer,
    goRouter: goRouter,
    overrides: overrides,
    widget: widget,
  );
  await tester.pumpAndSettle();
}

Future<void> pumpWidget(
  WidgetTester tester, {
  required Widget widget,
  Size? screenSize = defaultScreenSize,
  bool isConsumer = false,
  List<Override> overrides = const [],
  GoRouter? goRouter,
}) async {
  if (screenSize != null) {
    setupScreenSize(tester, screenSize);
  }
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: NavigationWrapper(
          mockGoRouter: goRouter,
          widget: ProviderScopeWrapper(
            isConsumer: isConsumer,
            overrides: overrides,
            widget: widget,
          ),
        ),
      ),
    ),
  );
}

void setupScreenSize(
  WidgetTester tester, [
  Size screenSize = defaultScreenSize,
]) =>
    tester.view.physicalSize = screenSize;
