import 'package:dio/dio.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/data/models/detailed_pokemon_model.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_list_response_model.dart';

final exception = Exception('test exception');

DioException createDioException({
  int statusCode = 600,
  DioExceptionType type = DioExceptionType.badResponse,
}) {
  return DioException(
    requestOptions: RequestOptions(path: 'path'),
    type: type,
    response: Response(
      requestOptions: RequestOptions(path: 'path'),
      statusCode: statusCode,
    ),
  );
}

PokemonListResponseModel createPokemonListResponseModel({
  int? maxCount,
  List<PokemonResultModel>? results,
}) {
  return PokemonListResponseModel(
    maxCount: maxCount ?? count,
    results: results ?? [createPokemonResultModel()],
  );
}

PokemonResultModel createPokemonResultModel({
  String? name,
  String? url,
}) {
  return PokemonResultModel(
    name: name ?? pokemonName,
    url: url ?? pokemonUrl,
  );
}

const grassPokemonTypeModel = PokemonTypeModel.grass;

PokemonStatModel createPokemonStatModel({
  int? baseStat,
  int? effort,
  String? statName,
}) {
  return PokemonStatModel(
    baseStat: baseStat ?? pokemonBaseStat,
    effort: effort ?? pokemonEffort,
    statName: statName ?? pokemonStatName,
  );
}

DetailedPokemonModel createDetailedPokemonModel({
  int? id,
  String? name,
  int? height,
  int? weight,
  List<PokemonTypeModel>? types,
  List<String>? moves,
  List<PokemonStatModel>? stats,
}) {
  return DetailedPokemonModel(
    id: id ?? pokemonId,
    name: name ?? pokemonName,
    height: height ?? pokemonHeight,
    weight: weight ?? pokemonWeight,
    types: types ?? [grassPokemonTypeModel],
    moves: moves ?? [pokemonMoveName],
    stats: stats ?? [createPokemonStatModel()],
  );
}
