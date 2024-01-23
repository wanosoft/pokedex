import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/pokedex_repository.dart';

part 'saved_pokemons_state.g.dart';

@riverpod
class SavedPokemonsState extends _$SavedPokemonsState {
  @override
  Future<List<DetailedPokemon>> build() async {
    final savedPokemons = await ref.watch(getAllSavedPokemonsProvider.future);
    return savedPokemons;
  }

  Future<void> removePokemon(int pokemonId) async {
    state = await AsyncValue.guard(() async {
      await ref.read(deletePokemonProvider(pokemonId).future);
      return state.asData!.value.where((p) => p.id != pokemonId).toList();
    });
  }

  Future<void> addPokemon(DetailedPokemon pokemon) async {
    state = await AsyncValue.guard(() async {
      await ref.read(savePokemonProvider(pokemon).future);
      return [...state.asData!.value, pokemon];
    });
  }
}
