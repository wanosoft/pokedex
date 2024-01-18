import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/all_pokemons/presentation/pokemons_screen.dart';
import '../features/my_favorites/presentation/favorites_screen.dart';
import '../features/pokemon_details/presentation/pokemon_details_screen.dart';
import 'presentation/home_screen.dart';
import 'presentation/routes.dart';

part 'presentation/router.dart';

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pokedex',
      routeInformationProvider: _router.routeInformationProvider,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
