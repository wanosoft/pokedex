import 'package:pokedex/core/data/mock_data.dart';
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
  String? id,
  String? name,
}) {
  return PokemonResult(
    id: id ?? pokemonId,
    name: name ?? pokemonName,
  );
}
