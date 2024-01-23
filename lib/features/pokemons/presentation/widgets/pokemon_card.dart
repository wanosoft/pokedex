import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/routes.dart';
import '../../domain/entities/pokemon.dart';
import '../entity_extensions.dart';

class PokemonCard extends ConsumerWidget {
  const PokemonCard._({
    required this.pokemon,
    super.key,
  });

  final Pokemon pokemon;

  bool get isDetailed => pokemon is DetailedPokemon;

  factory PokemonCard.fromPokemonResult(PokemonResult pokemon) {
    return PokemonCard._(
      pokemon: pokemon,
      key: Key(pokemon.id.toString()),
    );
  }

  factory PokemonCard.fromDetailedPokemon(DetailedPokemon pokemon) {
    return PokemonCard._(
      pokemon: pokemon,
      key: Key(pokemon.id.toString()),
    );
  }

  @override
  Widget build(context, ref) {
    return InkWell(
      onTap: () => context.pushNamed(
        PokedexRoutes.pokemon.name,
        extra: pokemon,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  pokemon.name,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(
                height: 100,
                image: NetworkImage(
                  pokemon.imageUrl,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  // TODO: Save/Remove pokemon from favorites
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
