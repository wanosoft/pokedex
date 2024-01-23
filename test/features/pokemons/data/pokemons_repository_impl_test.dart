import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/core/domain/entities/failure.dart';
import 'package:pokedex/features/pokemons/data/data_sources/pokedex_local_service.dart';
import 'package:pokedex/features/pokemons/data/data_sources/pokedex_remote_service.dart';
import 'package:pokedex/features/pokemons/data/pokemons_repository_impl.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon_list_response.dart';

import '../../../test_utils/entity_factory.dart';
import '../../../test_utils/model_factory.dart';

class MockPokedexRemoteService extends Mock implements PokedexRemoteService {}

class MockPokedexLocalService extends Mock implements PokedexLocalService {}

void main() {
  group('pokemons repository impl', () {
    late PokedexRemoteService remoteService;
    late PokedexLocalService localService;
    late PokemonsRepositoryImpl repository;

    final model = createDetailedPokemonModel();
    final pokemon = createDetailedPokemon();

    setUp(() {
      remoteService = MockPokedexRemoteService();
      localService = MockPokedexLocalService();
      repository = PokemonsRepositoryImpl(
        remoteService: remoteService,
        localService: localService,
      );
    });

    group('get pokemon list', () {
      const offset = 0;
      test('should return a pokemon list response', () async {
        when(() => remoteService.getPokemonList(offset: offset))
            .thenAnswer((_) async => createPokemonListResponseModel());

        final response = await repository.getPokemonList(offset: offset);

        expect(
          response,
          isA<PokemonListResponse>().having(
            (p0) => p0.results,
            'list',
            isA<List<PokemonResult>>(),
          ),
        );
        verify(() => remoteService.getPokemonList(offset: offset)).called(1);
        verifyNoMoreInteractions(remoteService);
        verifyZeroInteractions(localService);
      });

      test('should throw a failure', () {
        when(() => remoteService.getPokemonList(offset: offset)).thenThrow(
          exception,
        );

        expectLater(
          repository.getPokemonList(offset: offset),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });

    group('get pokemon details by id', () {
      test('should return a detailed pokemon', () async {
        when(() => remoteService.getPokemonDetailsById(pokemonId)).thenAnswer(
          (_) async => model,
        );

        final response = await repository.getPokemonDetailsById(pokemonId);

        expect(
          response,
          isA<DetailedPokemon>().having(
            (p0) => p0.name,
            'name',
            equals(pokemonName),
          ),
        );
        verify(() => remoteService.getPokemonDetailsById(pokemonId)).called(1);
        verifyNoMoreInteractions(remoteService);
        verifyZeroInteractions(localService);
      });

      test('should throw a failure', () {
        when(() => remoteService.getPokemonDetailsById(pokemonId)).thenThrow(
          exception,
        );

        expectLater(
          repository.getPokemonDetailsById(pokemonId),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });

    group('get all saved pokemons', () {
      test('should return a list of all saved pokemons', () async {
        when(() => localService.getAllSavedPokemons()).thenAnswer(
          (_) async => [model],
        );

        final response = await repository.getAllSavedPokemons();

        expect(
          response,
          isA<List<DetailedPokemon>>().having(
            (p0) => p0.single,
            'balbasaur',
            equals(pokemon),
          ),
        );
        verify(() => localService.getAllSavedPokemons()).called(1);
        verifyNoMoreInteractions(localService);
        verifyZeroInteractions(remoteService);
      });

      test('should throw a failure', () {
        when(() => localService.getAllSavedPokemons()).thenThrow(
          exception,
        );

        expectLater(
          repository.getAllSavedPokemons(),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });

    group('save pokemon', () {
      test('should return a the index of the saved pokemon', () async {
        when(() => localService.savePokemon(model)).thenAnswer(
          (_) async => pokemonId,
        );

        final response = await repository.savePokemon(pokemon);

        expect(response, equals(pokemonId));

        verify(() => localService.savePokemon(model)).called(1);
        verifyNoMoreInteractions(localService);
        verifyZeroInteractions(remoteService);
      });

      test('should throw a failure', () {
        when(() => localService.savePokemon(model)).thenThrow(
          exception,
        );

        expectLater(
          repository.savePokemon(pokemon),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });

    group('delete pokemon', () {
      test('should return true once the pokemon is deleted', () async {
        when(() => localService.deletePokemon(pokemonId)).thenAnswer(
          (_) async => true,
        );

        final response = await repository.deletePokemon(pokemonId);

        expect(response, true);

        verify(() => localService.deletePokemon(pokemonId)).called(1);
        verifyNoMoreInteractions(localService);
        verifyZeroInteractions(remoteService);
      });

      test('should throw a failure', () {
        when(() => localService.deletePokemon(pokemonId)).thenThrow(
          exception,
        );

        expectLater(
          repository.deletePokemon(pokemonId),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });
  });
}
