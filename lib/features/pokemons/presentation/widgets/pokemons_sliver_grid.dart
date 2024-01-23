import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/pokemon.dart';
import 'pokemon_card.dart';

class PokemonsSliverGrid extends ConsumerWidget {
  const PokemonsSliverGrid(
    this.pokemons, {
    super.key,
  });

  final List<Pokemon> pokemons;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final pokemon = pokemons[index];
          switch (pokemon) {
            case DetailedPokemon():
              return PokemonCard.fromDetailedPokemon(pokemon);
            case PokemonResult():
              return PokemonCard.fromPokemonResult(pokemon);
          }
        },
        childCount: pokemons.length,
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.6,
      ),
    );
  }
}
