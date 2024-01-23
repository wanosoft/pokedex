import '../domain/entities/pokemon.dart';

extension PokemonX on Pokemon {
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
