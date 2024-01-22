import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon.freezed.dart';

@freezed
sealed class Pokemon with _$Pokemon {
  const factory Pokemon.detailedPokemon({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<PokemonType> types,
    required List<String> moves,
    required List<PokemonStat> stats,
  }) = DetailedPokemon;

  const factory Pokemon.pokemonResult({
    required int id,
    required String name,
  }) = PokemonResult;
}

@freezed
class PokemonStat with _$PokemonStat {
  const factory PokemonStat({
    required int baseStat,
    required int effort,
    required String statName,
  }) = _PokemonStat;
}

enum PokemonType {
  normal,
  fighting,
  flying,
  poison,
  ground,
  rock,
  bug,
  ghost,
  steel,
  fire,
  water,
  grass,
  electric,
  psychic,
  ice,
  dragon,
  dark,
  fairy,
  unknown,
  shadow,
}
