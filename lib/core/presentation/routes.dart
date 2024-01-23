const pokemonIdKey = 'pokemonId';

enum PokedexRoutes {
  pokemons('/pokemons'),
  pokemon('/pokemon/:$pokemonIdKey'),
  favorites('/favorites');

  final String path;

  const PokedexRoutes(this.path);
}
