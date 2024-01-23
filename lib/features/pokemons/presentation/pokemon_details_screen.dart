import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/presentation/riverpod_extensions.dart';
import '../domain/entities/pokemon.dart';
import '../domain/pokedex_repository.dart';
import 'entity_extensions.dart';

class PokemonDetailsScreen extends ConsumerWidget {
  const PokemonDetailsScreen({
    required this.pokemon,
    super.key,
  });

  final Pokemon pokemon;

  @override
  Widget build(context, ref) {
    final state = ref.watch(getPokemonDetailsByIdProvider(pokemon.id));
    return Scaffold(
      backgroundColor: Colors.blue,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: state.renderWhen((data) => Text(data.name)),
              background: state.renderWhen(
                (data) => Image.network(
                  pokemon.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              ListTile(
                title: const Text('Height'),
                subtitle: Text(state.data?.height.toString() ?? ''),
              ),
              ListTile(
                title: const Text('Weight'),
                subtitle: Text(state.data?.weight.toString() ?? ''),
              ),
              ListTile(
                title: const Text('Types'),
                subtitle: Text(state.data?.types.join(', ') ?? ''),
              ),
              ListTile(
                title: const Text('Abilities'),
                subtitle: Text(state.data?.abilities.join(', ') ?? ''),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
