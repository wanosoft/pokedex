import 'package:freezed_annotation/freezed_annotation.dart';

part 'detailed_pokemon.freezed.dart';

@freezed
class DetailedPokemon with _$DetailedPokemon {
  const factory DetailedPokemon({
    required int id,
    required String name,
    required int height,
    required int weight,
    required List<PokemonType> types,
    required List<String> moves,
    required List<PokemonStat> stats,
  }) = _DetailedPokemon;
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
