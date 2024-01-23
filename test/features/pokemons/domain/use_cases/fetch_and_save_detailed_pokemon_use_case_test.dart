import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/core/domain/entities/failure.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';
import 'package:pokedex/features/pokemons/domain/use_cases/fetch_and_save_detailed_pokemon_use_case.dart';

import '../../../../test_utils/entity_factory.dart';
import '../../../../test_utils/mocks.dart';

void main() {
  group('fetch and save detailed pokemon use case', () {
    late PokedexRepository repository;
    late FetchAndSaveDetailedPokemonUseCase useCase;
    final detailedPokemon = createDetailedPokemon();

    setUp(() {
      repository = MockPokedexRepository();
      useCase = FetchAndSaveDetailedPokemonUseCase(repository);
    });

    test('should succeed and return pokemon id', () async {
      when(() => repository.getPokemonDetailsById(pokemonId))
          .thenAnswer((_) async => detailedPokemon);
      when(() => repository.savePokemon(detailedPokemon))
          .thenAnswer((_) async => pokemonId);

      final result = await useCase(pokemonId);

      expect(result, equals(pokemonId));
      verify(() => repository.getPokemonDetailsById(pokemonId)).called(1);
      verify(() => repository.savePokemon(detailedPokemon)).called(1);
      verifyNoMoreInteractions(repository);
    });

    group('should fail', () {
      test('on getting detailed pokemon step', () {
        when(() => repository.getPokemonDetailsById(pokemonId)).thenThrow(
          const Failure.serverFailure(message: ''),
        );

        expectLater(
          useCase.call(pokemonId),
          throwsA(isA<ServerFailure>()),
        );

        verify(() => repository.getPokemonDetailsById(pokemonId)).called(1);
        verifyNoMoreInteractions(repository);
      });

      test('on save pokemon step', () {
        when(() => repository.getPokemonDetailsById(pokemonId))
            .thenAnswer((_) async => detailedPokemon);
        when(() => repository.savePokemon(detailedPokemon)).thenThrow(
          const Failure.unknownFailure(message: ''),
        );

        expectLater(
          useCase.call(pokemonId),
          throwsA(isA<UnknownFailure>()),
        );

        verify(() => repository.getPokemonDetailsById(pokemonId)).called(1);
        verifyNoMoreInteractions(repository);
      });
    });
  });
}
