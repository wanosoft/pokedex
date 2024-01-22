import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/core/domain/entities/failure.dart';
import 'package:pokedex/features/pokemons/data/data_sources/pokedex_remote_service.dart';
import 'package:pokedex/features/pokemons/data/pokemons_repository_impl.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon_list_response.dart';

import '../../../test_utils/model_factory.dart';

class MockPokedexRemoteService extends Mock implements PokedexRemoteService {}

void main() {
  group('pokemons repository impl', () {
    late PokedexRemoteService remoteService;
    late PokemonsRepositoryImpl repository;

    setUp(() {
      remoteService = MockPokedexRemoteService();
      repository = PokemonsRepositoryImpl(remoteService: remoteService);
    });

    group('get pokemon list', () {
      test('should return a pokemon list response', () async {
        when(() => remoteService.getPokemonList(offset: 0))
            .thenAnswer((_) async => createPokemonListResponseModel());

        final response = await repository.getPokemonList(offset: 0);

        expect(
          response,
          isA<PokemonListResponse>().having(
            (p0) => p0.results,
            'list',
            isA<List<PokemonResult>>(),
          ),
        );
        verify(() => remoteService.getPokemonList(offset: 0)).called(1);
        verifyNoMoreInteractions(remoteService);
      });

      test('should throw a failure', () {
        when(() => remoteService.getPokemonList(offset: 0)).thenThrow(
          exception,
        );

        expectLater(
          repository.getPokemonList(offset: 0),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });

    group('get pokemon details by id', () {
      final id = pokemonId.toString();

      test('should return a detailed pokemon', () async {
        when(() => remoteService.getPokemonDetailsById(id)).thenAnswer(
          (_) async => createDetailedPokemonModel(),
        );

        final response = await repository.getPokemonDetailsById(id);

        expect(
          response,
          isA<DetailedPokemon>().having(
            (p0) => p0.name,
            'name',
            equals(pokemonName),
          ),
        );
        verify(() => remoteService.getPokemonDetailsById(id)).called(1);
        verifyNoMoreInteractions(remoteService);
      });

      test('should throw a failure', () {
        when(() => remoteService.getPokemonDetailsById(id)).thenThrow(
          exception,
        );

        expectLater(
          repository.getPokemonDetailsById(id),
          throwsA(isA<UnknownFailure>()),
        );
      });
    });
  });
}
