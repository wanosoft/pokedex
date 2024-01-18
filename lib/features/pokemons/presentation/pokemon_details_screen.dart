import 'package:flutter/material.dart';

class PokemonDetailsScreen extends StatelessWidget {
  const PokemonDetailsScreen({
    required this.pokemonId,
    super.key,
  });

  final String pokemonId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        title: const Text('Pokemon details'),
      ),
      body: Center(
        child: Text('Pokemon id: $pokemonId'),
      ),
    );
  }
}
