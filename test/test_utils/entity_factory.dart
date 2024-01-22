import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon.dart';
import 'package:pokedex/features/pokemons/domain/entities/pokemon_list_response.dart';

PokemonListResponse createPokemonListResponse({
  int? maxCount,
  List<PokemonResult>? results,
}) {
  return PokemonListResponse(
    maxCount: maxCount ?? count,
    results: results ?? [createPokemonResult()],
  );
}

PokemonResult createPokemonResult({
  int? id,
  String? name,
}) {
  return PokemonResult(
    id: id ?? pokemonId,
    name: name ?? pokemonName,
  );
}

const grassPokemonType = PokemonType.grass;

PokemonStat createPokemonStat({
  int? baseStat,
  int? effort,
  String? statName,
}) {
  return PokemonStat(
    baseStat: baseStat ?? pokemonBaseStat,
    effort: effort ?? pokemonEffort,
    statName: statName ?? pokemonStatName,
  );
}

DetailedPokemon createDetailedPokemon({
  int? id,
  String? name,
  int? height,
  int? weight,
  List<PokemonType>? types,
  List<String>? moves,
  List<PokemonStat>? stats,
}) {
  return DetailedPokemon(
    id: id ?? pokemonId,
    name: name ?? pokemonName,
    height: height ?? pokemonHeight,
    weight: weight ?? pokemonWeight,
    types: types ?? [grassPokemonType],
    moves: moves ?? [pokemonMoveName],
    stats: stats ?? [createPokemonStat()],
  );
}
