import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/routes.dart';
import '../../domain/entities/pokemon.dart';
import '../entity_extensions.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard._({
    required this.pokemon,
    this.types = const [],
    super.key,
  });
  
  final Pokemon pokemon;
  final List<PokemonType> types;

  factory PokemonCard.fromPokemonResult(PokemonResult pokemon) {
    return PokemonCard._(
      pokemon: pokemon,
      key: Key(pokemon.id.toString()),
    );
  }

  factory PokemonCard.fromDetailedPokemon(DetailedPokemon pokemon) {
    return PokemonCard._(
      pokemon: pokemon,
      types: pokemon.types,
      key: Key(pokemon.id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
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
          ],
        ),
      ),
    );
  }
}
