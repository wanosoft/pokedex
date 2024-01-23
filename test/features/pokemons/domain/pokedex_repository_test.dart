import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon_list_response.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';

import '../../../test_utils/entity_factory.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {}

void main() {
  group('pokedex repository', () {
    const offset = 0;
    late PokedexRepository pokedexRepository;
    late ProviderContainer container;

    setUp(() {
      pokedexRepository = MockPokedexRepository();
      container = ProviderContainer(
        overrides: [
          pokedexRepositoryProvider.overrideWithValue(pokedexRepository),
        ],
      );
    });

    test('should get pokemon list', () async {
      final expected = createPokemonListResponse();

      when(() => pokedexRepository.getPokemonList(offset: offset))
          .thenAnswer((_) async => expected);

      expect(
        container.read(getPokemonListProvider(offset: offset)),
        const AsyncValue<PokemonListResponse>.loading(),
      );

      await container.read(getPokemonListProvider(offset: offset).future);

      expect(
        container.read(getPokemonListProvider(offset: offset)).value,
        expected,
      );
    });

    test('should get pokemon details by id', () async {
      final expected = createDetailedPokemon();

      when(() => pokedexRepository.getPokemonDetailsById(pokemonId))
          .thenAnswer((_) async => expected);

      expect(
        container.read(getPokemonDetailsByIdProvider(pokemonId)),
        const AsyncValue<DetailedPokemon>.loading(),
      );

      await container.read(getPokemonDetailsByIdProvider(pokemonId).future);

      expect(
        container.read(getPokemonDetailsByIdProvider(pokemonId)).value,
        expected,
      );
    });

    test('should get all saved pokemons', () async {
      final expected = [createDetailedPokemon()];

      when(() => pokedexRepository.getAllSavedPokemons())
          .thenAnswer((_) async => expected);

      expect(
        container.read(getAllSavedPokemonsProvider),
        const AsyncValue<List<DetailedPokemon>>.loading(),
      );

      await container.read(getAllSavedPokemonsProvider.future);

      expect(
        container.read(getAllSavedPokemonsProvider).value,
        expected,
      );
    });

    test('should save pokemon', () async {
      final pokemon = createDetailedPokemon();
      when(() => pokedexRepository.savePokemon(pokemon))
          .thenAnswer((_) async => pokemonId);

      expect(
        container.read(savePokemonProvider(pokemon)),
        const AsyncValue<int>.loading(),
      );

      await container.read(savePokemonProvider(pokemon).future);

      expect(
        container.read(savePokemonProvider(pokemon)).value,
        pokemonId,
      );
    });

    test('should delete pokemon', () async {
      const result = true;
      when(() => pokedexRepository.deletePokemon(pokemonId))
          .thenAnswer((_) async => result);

      expect(
        container.read(deletePokemonProvider(pokemonId)),
        const AsyncValue<bool>.loading(),
      );

      await container.read(deletePokemonProvider(pokemonId).future);

      expect(container.read(deletePokemonProvider(pokemonId)).value, result);
    });
  });
}
