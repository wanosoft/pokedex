import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/local_config.dart';
import '../models/detailed_pokemon_model.dart';

part 'pokedex_local_service.g.dart';

@Riverpod(keepAlive: true)
PokedexLocalService pokedexLocalService(PokedexLocalServiceRef ref) {
  final database = ref.watch(pokedexDatabaseProvider);
  return PokedexLocalService(database);
}

class PokedexLocalService {
  const PokedexLocalService(this._database);

  final PokedexDatabase _database;

  Future<List<DetailedPokemonModel>> getAllSavedPokemons() async {
    final pokemons = await _database.localPokemon.select().get();
    return pokemons
        .map(
          (pokemon) => DetailedPokemonModel(
            id: pokemon.id,
            name: pokemon.name,
            height: pokemon.height,
            weight: pokemon.weight,
            types: pokemon.types,
            moves: pokemon.moves,
            stats: pokemon.stats,
          ),
        )
        .toList();
  }

  Future<int> savePokemon(DetailedPokemonModel pokemon) async {
    return await _database.into(_database.localPokemon).insertOnConflictUpdate(
          LocalPokemonCompanion.insert(
            id: Value(pokemon.id),
            name: pokemon.name,
            height: pokemon.height,
            weight: pokemon.weight,
            types: pokemon.types,
            moves: pokemon.moves,
            stats: pokemon.stats,
          ),
        );
  }

  Future<bool> deletePokemon(int pokemonId) async {
    final savedPokemons = _database.select(_database.localPokemon)
      ..where((table) => table.id.equals(pokemonId));
    final pokemon = await savedPokemons.getSingleOrNull();
    if (pokemon != null) {
      await (_database.localPokemon.deleteOne(pokemon.toCompanion(true)));
    }
    return false;
  }
}
