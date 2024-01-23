import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';
import 'package:pokedex/features/pokemons/presentation/saved_pokemons/saved_pokemons_state.dart';

import '../../../../test_utils/entity_factory.dart';
import '../../../../test_utils/mocks.dart';
import '../../../../test_utils/test_utils.dart';

void main() {
  late MockPokedexRepository pokedexRepository;
  late ProviderContainer container;

  setUp(() {
    pokedexRepository = MockPokedexRepository();

    container = createContainer(
      overrides: [
        pokedexRepositoryProvider.overrideWith((ref) => pokedexRepository),
      ],
    );
  });

  group('saved pokemons state notifier', () {
    test('should return saved pokemons', () async {
      final expected = [createDetailedPokemon()];

      when(
        () => pokedexRepository.getAllSavedPokemons(),
      ).thenAnswer((_) async => expected);

      final result =
          await container.read(savedPokemonsStateProvider.notifier).build();

      expect(result, expected);
      verify(() => pokedexRepository.getAllSavedPokemons()).called(1);
      verifyNoMoreInteractions(pokedexRepository);
    });

    test('should add a new pokemon to the state', () async {
      final pokemon = createDetailedPokemon();
      final expected = [pokemon];

      when(
        () => pokedexRepository.getAllSavedPokemons(),
      ).thenAnswer((_) async => []);
      when(
        () => pokedexRepository.savePokemon(pokemon),
      ).thenAnswer((_) async => pokemonId);

      final initialState =
          await container.read(savedPokemonsStateProvider.notifier).build();

      expect(initialState, isEmpty);

      await container
          .read(savedPokemonsStateProvider.notifier)
          .addPokemon(pokemon);

      final result = container.read(savedPokemonsStateProvider.notifier).state;

      expect(result.asData!.value, expected);

      verify(() => pokedexRepository.getAllSavedPokemons()).called(1);
      verify(() => pokedexRepository.savePokemon(pokemon)).called(1);
      verifyNoMoreInteractions(pokedexRepository);
    });

    test('should remove pokemon from the state', () async {
      final pokemon = createDetailedPokemon();
      final expected = [pokemon];

      when(
        () => pokedexRepository.getAllSavedPokemons(),
      ).thenAnswer((_) async => expected);
      when(
        () => pokedexRepository.deletePokemon(pokemonId),
      ).thenAnswer((_) async => true);

      final initialState =
          await container.read(savedPokemonsStateProvider.notifier).build();

      expect(initialState, expected);

      await container
          .read(savedPokemonsStateProvider.notifier)
          .removePokemon(pokemonId);

      final result = container.read(savedPokemonsStateProvider.notifier).state;

      expect(result.asData!.value, isEmpty);

      verify(() => pokedexRepository.getAllSavedPokemons()).called(1);
      verify(() => pokedexRepository.deletePokemon(pokemonId)).called(1);
      verifyNoMoreInteractions(pokedexRepository);
    });
  });
}
