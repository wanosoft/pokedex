import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/data_sources/pokedex_remote_service.dart';
import '../data/pokemons_repository_impl.dart';
import 'entities/pokemon.dart';
import 'entities/pokemon_list_response.dart';

part 'pokedex_repository.g.dart';

@Riverpod(keepAlive: true)
PokedexRepository pokedexRepository(PokedexRepositoryRef ref) {
  final remoteService = ref.watch(pokedexRemoteServiceProvider);
  return PokemonsRepositoryImpl(remoteService: remoteService);
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
  String id,
) {
  final repository = ref.watch(pokedexRepositoryProvider);
  return repository.getPokemonDetailsById(id);
}

abstract class PokedexRepository {
  Future<PokemonListResponse> getPokemonList({
    required int offset,
    int limit = 25,
  });

  Future<DetailedPokemon> getPokemonDetailsById(String id);
}
