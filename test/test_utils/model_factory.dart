import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_list_response_model.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_result_model.dart';

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
