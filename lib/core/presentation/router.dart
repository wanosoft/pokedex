part of '../pokedex_app.dart';

final _parentNavigatorKey = GlobalKey<NavigatorState>();

final _router = GoRouter(
  navigatorKey: _parentNavigatorKey,
  initialLocation: PokedexRoutes.pokemons.path,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (_, __, child) => HomeScreen(navigationShell: child),
      parentNavigatorKey: _parentNavigatorKey,
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: PokedexRoutes.pokemons.name,
              path: PokedexRoutes.pokemons.path,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: FetchedPokemonsScreen(),
              ),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              name: PokedexRoutes.favorites.name,
              path: PokedexRoutes.favorites.path,
              pageBuilder: (_, __) => const NoTransitionPage(
                child: FavoritesScreen(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      parentNavigatorKey: _parentNavigatorKey,
      name: PokedexRoutes.pokemon.name,
      path: PokedexRoutes.pokemon.path,
      builder: (context, state) => PokemonDetailsScreen(
        pokemon: state.extra as Pokemon,
      ),
    ),
  ],
);
