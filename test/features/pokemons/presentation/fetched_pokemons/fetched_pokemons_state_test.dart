import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';
import 'package:pokedex/features/pokemons/presentation/fetched_pokemons/fetched_pokemons_state.dart';

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

  group('fetched pokemons state notifier', () {
    const maxCount = FetchedPokemons.limit * 2;
    const initialOffset = 0;
    final results = List.generate(
      25,
      (index) => createPokemonResult(id: index + 1),
    );
    final firstResponse = createPokemonListResponse(
      maxCount: maxCount,
      results: results,
    );
    final firstExpected = FetchedPokemons(
      maxCount: maxCount,
      offset: initialOffset,
      pokemonResults: results,
    );

    test('should fetch pokemons', () async {
      when(
        () => pokedexRepository.getPokemonList(
          offset: initialOffset,
          limit: FetchedPokemons.limit,
        ),
      ).thenAnswer((_) async => firstResponse);

      final result =
          await container.read(fetchedPokemonsStateProvider.notifier).build();

      expect(result, firstExpected);

      verify(
        () => pokedexRepository.getPokemonList(
          offset: FetchedPokemons.limit,
          limit: FetchedPokemons.limit,
        ),
      ).called(1);
      verifyNoMoreInteractions(pokedexRepository);
    });

    test('should load more', () async {
      final loadMorePokemonResults = List.generate(
        FetchedPokemons.limit,
        (index) => createPokemonResult(
          id: index + FetchedPokemons.limit + 1,
        ),
      );

      when(
        () => pokedexRepository.getPokemonList(
          offset: 0,
          limit: FetchedPokemons.limit,
        ),
      ).thenAnswer(
        (_) async => firstResponse.copyWith(
          results: List.generate(
            FetchedPokemons.limit,
            (index) => createPokemonResult(
              id: index + 1,
            ),
          ),
        ),
      );

      when(
        () => pokedexRepository.getPokemonList(
          offset: FetchedPokemons.limit,
          limit: FetchedPokemons.limit,
        ),
      ).thenAnswer(
        (_) async => firstResponse.copyWith(results: loadMorePokemonResults),
      );

      final initialState =
          await container.read(fetchedPokemonsStateProvider.notifier).build();

      expect(initialState, firstExpected);

      await container.read(fetchedPokemonsStateProvider.notifier).loadMore();

      expect(
        container.read(fetchedPokemonsStateProvider.notifier).state.value,
        firstExpected.copyWith(
          offset: FetchedPokemons.limit,
          pokemonResults: [
            ...firstExpected.pokemonResults,
            ...loadMorePokemonResults,
          ],
        ),
      );

      verify(
        () => pokedexRepository.getPokemonList(
          offset: any(named: 'offset'),
          limit: any(named: 'limit'),
        ),
      ).called(2);
      verifyNoMoreInteractions(pokedexRepository);
    });
  });
}
