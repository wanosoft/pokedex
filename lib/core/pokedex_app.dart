import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/pokemons/domain/entities/pokemon.dart';
import '../features/pokemons/presentation/fetched_pokemons/fetched_pokemons_screen.dart';
import '../features/pokemons/presentation/pokemon_details_screen.dart';
import '../features/pokemons/presentation/saved_pokemons/saved_pokemons_screen.dart';
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
