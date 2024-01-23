import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/pokedex_repository.dart';

part 'fetched_pokemons_state.g.dart';
part 'fetched_pokemons_state.freezed.dart';

@freezed
class FetchedPokemons with _$FetchedPokemons {
  const FetchedPokemons._();

  const factory FetchedPokemons({
    required int maxCount,
    required int offset,
    required List<PokemonResult> pokemonResults,
  }) = _FetchedPokemons;

  static const limit = 25;

  bool get hasReachedMax => offset >= maxCount;
}

@Riverpod()
class FetchedPokemonsState extends _$FetchedPokemonsState {
  @override
  Future<FetchedPokemons> build() async {
    final response = await ref.watch(
      getPokemonListProvider(
        offset: 0,
        limit: FetchedPokemons.limit,
      ).future,
    );
    return FetchedPokemons(
      maxCount: response.maxCount,
      offset: 0,
      pokemonResults: response.results,
    );
  }

  Future<void> loadMore() async {
    if (state.isLoading || state.hasError) {
      return;
    }

    /// If is not loading and has no error then it is safe to unwrap the state
    final oldState = state.asData!.value;

    final newOffset = oldState.offset + FetchedPokemons.limit;
    final currentMaxCount = oldState.maxCount;

    // If the future offset will be greater than or equal to the max count then
    // there is no need to load more
    if (newOffset >= currentMaxCount) {
      return;
    }

    final currentPokemonResults = oldState.pokemonResults;

    state = await AsyncValue.guard(() async {
      final newPokemonList = await ref.watch(
        getPokemonListProvider(
          offset: newOffset,
          limit: FetchedPokemons.limit,
        ).future,
      );

      return oldState.copyWith(
        maxCount: newPokemonList.maxCount,
        offset: newOffset,
        pokemonResults: [...currentPokemonResults, ...newPokemonList.results],
      );
    });
  }
}
