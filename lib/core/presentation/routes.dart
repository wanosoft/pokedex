enum PokedexRoutes {
  pokemons('/pokemons'),
  pokemon('/pokemon/:pokemonId'),
  favorites('/favorites');

  final String path;

  const PokedexRoutes(this.path);
}
