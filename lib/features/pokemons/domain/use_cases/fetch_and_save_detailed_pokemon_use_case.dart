import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../pokedex_repository.dart';

part 'fetch_and_save_detailed_pokemon_use_case.g.dart';

@riverpod
FetchAndSaveDetailedPokemonUseCase fetchAndSaveDetailedPokemonUseCase(
  FetchAndSaveDetailedPokemonUseCaseRef ref,
) {
  final repository = ref.read(pokedexRepositoryProvider);
  return FetchAndSaveDetailedPokemonUseCase(repository);
}

/// Fetchs and saves a [DetailedPokemon] by its [pokemonId].
class FetchAndSaveDetailedPokemonUseCase {
  final PokedexRepository _pokedexRepository;

  FetchAndSaveDetailedPokemonUseCase(this._pokedexRepository);

  Future<int> call(int pokemonId) async {
    try {
      final detailedPokemon = await _pokedexRepository.getPokemonDetailsById(
        pokemonId,
      );

      return await _pokedexRepository.savePokemon(detailedPokemon);
    } catch (_) {
      rethrow;
    }
  }
}
