import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/data_sources/pokedex_local_service.dart';
import '../data/data_sources/pokedex_remote_service.dart';
import '../data/pokemons_repository_impl.dart';
import 'entities/pokemon.dart';
import 'entities/pokemon_list_response.dart';

part 'pokedex_repository.g.dart';

@Riverpod(keepAlive: true)
PokedexRepository pokedexRepository(PokedexRepositoryRef ref) {
  final remoteService = ref.watch(pokedexRemoteServiceProvider);
  final localService = ref.watch(pokedexLocalServiceProvider);

  return PokemonsRepositoryImpl(
    remoteService: remoteService,
    localService: localService,
  );
}

@riverpod
Future<PokemonListResponse> getPokemonList(
  GetPokemonListRef ref, {
  required int offset,
  int limit = 25,
}) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.getPokemonList(offset: offset, limit: limit);
}

@riverpod
Future<DetailedPokemon> getPokemonDetailsById(
  GetPokemonDetailsByIdRef ref,
  int id,
) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.getPokemonDetailsById(id);
}

@riverpod
Future<List<DetailedPokemon>> getAllSavedPokemons(GetAllSavedPokemonsRef ref) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.getAllSavedPokemons();
}

@riverpod
Future<int> savePokemon(SavePokemonRef ref, DetailedPokemon pokemon) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.savePokemon(pokemon);
}

@riverpod
Future<bool> deletePokemon(DeletePokemonRef ref, int pokemonId) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.deletePokemon(pokemonId);
}

abstract class PokedexRepository {
  Future<PokemonListResponse> getPokemonList({
    required int offset,
    int limit = 25,
  });
  Future<DetailedPokemon> getPokemonDetailsById(int id);
  Future<List<DetailedPokemon>> getAllSavedPokemons();
  Future<int> savePokemon(DetailedPokemon pokemon);
  Future<bool> deletePokemon(int pokemonId);
}
