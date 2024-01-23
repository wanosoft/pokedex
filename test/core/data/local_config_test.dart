import 'dart:io';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/local_config.dart';

import '../../test_utils/test_utils.dart';

abstract class GetDocumentsDirectory {
  Future<Directory> call();
}

class MockGetDocumentsDirectory extends Mock implements GetDocumentsDirectory {}

void main() {
  group('local config', () {
    late GetDocumentsDirectory getDocumentsDirectory;
    late Directory directory;
    late ProviderContainer container;

    setUp(() {
      getDocumentsDirectory = MockGetDocumentsDirectory();
      directory = Directory('test');

      when(() => getDocumentsDirectory()).thenAnswer((_) async => directory);

      container = createContainer(
        overrides: [
          getDocumentsDirectoryProvider.overrideWith(
            (ref) => getDocumentsDirectory.call,
          ),
        ],
      );
    });

    test(
      'getDocumentsDirectory provider should return a valid directory getter',
      () async {
        final result = await container.read(getDocumentsDirectoryProvider)();

        expect(result, directory);
        verify(() => getDocumentsDirectory()).called(1);
        verifyNoMoreInteractions(getDocumentsDirectory);
      },
    );

    test(
      'queryExecutor provider should return a valid LazyDatabase query executor',
      () async {
        final result = container.read(queryExecutorProvider);

        expect(result, isA<LazyDatabase>());
        verifyZeroInteractions(getDocumentsDirectory);
      },
    );

    test(
      'pokedexDatabaseProvider should return a valid database',
      () async {
        final result = container.read(pokedexDatabaseProvider);

        expect(
          result,
          isA<PokedexDatabase>().having(
            (db) => db.schemaVersion,
            'Schema Version',
            1,
          ),
        );
        verifyZeroInteractions(getDocumentsDirectory);
      },
    );
  });
}
