enum PokedexRoutes {
  pokemons('/pokemons'),
  pokemon('/pokemon'),
  favorites('/favorites');

  final String path;

  const PokedexRoutes(this.path);
}
