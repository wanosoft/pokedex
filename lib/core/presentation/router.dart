part of '../pokedex_app.dart';

final _router = GoRouter(
  initialLocation: PokedexRoutes.pokemons.path,
  routes: [
    ShellRoute(
      builder: (_, __, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          name: PokedexRoutes.pokemons.name,
          path: PokedexRoutes.pokemons.path,
          pageBuilder: (_, __) => const NoTransitionPage(
            child: PokemonsScreen(),
          ),
        ),
        GoRoute(
          name: PokedexRoutes.favorites.name,
          path: PokedexRoutes.favorites.path,
          pageBuilder: (_, __) => const NoTransitionPage(
            child: FavoritesScreen(),
          ),
        ),
      ],
    ),
    GoRoute(
      name: PokedexRoutes.pokemon.name,
      path: PokedexRoutes.pokemon.path,
      builder: (context, state) => PokemonDetailsScreen(
        pokemonId: state.pathParameters['pokemonId'] as String,
      ),
    ),
  ],
);
