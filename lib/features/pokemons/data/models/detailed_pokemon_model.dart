import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon.dart';

part 'detailed_pokemon_model.freezed.dart';
part 'detailed_pokemon_model.g.dart';

@freezed
class DetailedPokemonModel with _$DetailedPokemonModel {
  const DetailedPokemonModel._();

  const factory DetailedPokemonModel({
    required int id,
    required String name,
    required int height,
    required int weight,
    @PokemonTypesModelConverter() required List<PokemonTypeModel> types,
    @PokemonMovesConverter() required List<String> moves,
    required List<PokemonStatModel> stats,
  }) = _DetailedPokemonModel;

  factory DetailedPokemonModel.fromJson(Map<String, dynamic> json) =>
      _$DetailedPokemonModelFromJson(json);

  DetailedPokemon toDetailedPokemon() => DetailedPokemon(
        id: id,
        name: name,
        height: height,
        weight: weight,
        types: types.map((e) => e.toPokemonType()).toList(),
        moves: moves,
        stats: stats.map((e) => e.toPokemonStat()).toList(),
      );
}

@freezed
class PokemonStatModel with _$PokemonStatModel {
  const PokemonStatModel._();

  const factory PokemonStatModel({
    @JsonKey(name: 'base_stat') required int baseStat,
    required int effort,
    @JsonKey(name: 'stat') @StatNameConverter() required String statName,
  }) = _PokemonStatModel;

  factory PokemonStatModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonStatModelFromJson(json);

  PokemonStat toPokemonStat() => PokemonStat(
        baseStat: baseStat,
        effort: effort,
        statName: statName,
      );
}

enum PokemonTypeModel {
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
  shadow;

  static PokemonTypeModel fromJson(Map<String, dynamic> json) {
    switch (json['type']['name'] as String) {
      case 'normal':
        return PokemonTypeModel.normal;
      case 'fighting':
        return PokemonTypeModel.fighting;
      case 'flying':
        return PokemonTypeModel.flying;
      case 'poison':
        return PokemonTypeModel.poison;
      case 'ground':
        return PokemonTypeModel.ground;
      case 'rock':
        return PokemonTypeModel.rock;
      case 'bug':
        return PokemonTypeModel.bug;
      case 'ghost':
        return PokemonTypeModel.ghost;
      case 'steel':
        return PokemonTypeModel.steel;
      case 'fire':
        return PokemonTypeModel.fire;
      case 'water':
        return PokemonTypeModel.water;
      case 'grass':
        return PokemonTypeModel.grass;
      case 'electric':
        return PokemonTypeModel.electric;
      case 'psychic':
        return PokemonTypeModel.psychic;
      case 'ice':
        return PokemonTypeModel.ice;
      case 'dragon':
        return PokemonTypeModel.dragon;
      case 'dark':
        return PokemonTypeModel.dark;
      case 'fairy':
        return PokemonTypeModel.fairy;
      case 'unknown':
        return PokemonTypeModel.unknown;
      case 'shadow':
        return PokemonTypeModel.shadow;
      default:
        throw Exception('Unknown type');
    }
  }

  PokemonType toPokemonType() {
    switch (this) {
      case PokemonTypeModel.normal:
        return PokemonType.normal;
      case PokemonTypeModel.fighting:
        return PokemonType.fighting;
      case PokemonTypeModel.flying:
        return PokemonType.flying;
      case PokemonTypeModel.poison:
        return PokemonType.poison;
      case PokemonTypeModel.ground:
        return PokemonType.ground;
      case PokemonTypeModel.rock:
        return PokemonType.rock;
      case PokemonTypeModel.bug:
        return PokemonType.bug;
      case PokemonTypeModel.ghost:
        return PokemonType.ghost;
      case PokemonTypeModel.steel:
        return PokemonType.steel;
      case PokemonTypeModel.fire:
        return PokemonType.fire;
      case PokemonTypeModel.water:
        return PokemonType.water;
      case PokemonTypeModel.grass:
        return PokemonType.grass;
      case PokemonTypeModel.electric:
        return PokemonType.electric;
      case PokemonTypeModel.psychic:
        return PokemonType.psychic;
      case PokemonTypeModel.ice:
        return PokemonType.ice;
      case PokemonTypeModel.dragon:
        return PokemonType.dragon;
      case PokemonTypeModel.dark:
        return PokemonType.dark;
      case PokemonTypeModel.fairy:
        return PokemonType.fairy;
      case PokemonTypeModel.unknown:
        return PokemonType.unknown;
      case PokemonTypeModel.shadow:
        return PokemonType.shadow;
    }
  }
}

class StatNameConverter implements JsonConverter<String, Map<String, dynamic>> {
  const StatNameConverter();

  @override
  String fromJson(Map<String, dynamic> json) {
    return json['name'] as String;
  }

  @override
  Map<String, dynamic> toJson(String object) {
    return {
      'name': object,
    };
  }
}

class PokemonTypesModelConverter
    implements JsonConverter<List<PokemonTypeModel>, List<dynamic>> {
  const PokemonTypesModelConverter();

  @override
  List<PokemonTypeModel> fromJson(List<dynamic> json) {
    return json.map((e) => PokemonTypeModel.fromJson(e)).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<PokemonTypeModel> object) {
    return object
        .map(
          (e) => {
            'type': {
              'name': e.toPokemonType().name,
            }
          },
        )
        .toList();
  }
}

class PokemonMovesConverter
    implements JsonConverter<List<String>, List<dynamic>> {
  const PokemonMovesConverter();

  @override
  List<String> fromJson(List<dynamic> json) {
    return json.map((e) => e['move']['name'] as String).toList();
  }

  @override
  List<Map<String, dynamic>> toJson(List<String> object) {
    return object
        .map(
          (e) => {
            'move': {
              'name': e,
            }
          },
        )
        .toList();
  }
}
