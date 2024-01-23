import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/presentation/routes.dart';
import '../../domain/entities/pokemon.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard._({
    required this.id,
    required this.name,
    this.types = const [],
    super.key,
  });

  final int id;
  final String name;
  final List<PokemonType> types;

  factory PokemonCard.fromPokemonResult(PokemonResult pokemon) {
    return PokemonCard._(
      id: pokemon.id.toInt(),
      name: pokemon.name,
      key: Key(pokemon.id.toString()),
    );
  }

  factory PokemonCard.fromDetailedPokemon(DetailedPokemon pokemon) {
    return PokemonCard._(
      id: pokemon.id,
      name: pokemon.name,
      types: pokemon.types,
      key: Key(pokemon.id.toString()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed(
        PokedexRoutes.pokemon.name,
        pathParameters: {pokemonIdKey: id.toString()},
      ),
      child: Container(
        decoration: BoxDecoration(
          // TODO: change color based on pokemon type
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Stack(
          children: [
            Column(
              children: [
                Text(
                  name,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Image(
                height: 100,
                image: NetworkImage(
                  'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
