import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/riverpod_extensions.dart';
import '../widgets/pokemons_sliver_grid.dart';
import 'saved_pokemons_state.dart';

class SavedPokemonsScreen extends ConsumerWidget {
  const SavedPokemonsScreen({super.key});

  @override
  Widget build(context, ref) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: CustomScrollView(
        key: const Key('saved-pokemons-screen'),
        slivers: [
          SliverAppBar(
            title: const Text('Saved Pokemons'),
            titleTextStyle: Theme.of(context).textTheme.displayMedium,
            centerTitle: false,
            expandedHeight: 100,
            floating: false,
            pinned: true,
          ),
          ref.watch(savedPokemonsStateProvider).renderWhen(
                (data) => SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (data.isEmpty) {
                        return const Center(
                          child: Text('No saved pokemons'),
                        );
                      }

                      return PokemonsSliverGrid(data);
                    },
                    childCount: data.length,
                  ),
                ),
                onRetry: () =>
                    ref.read(savedPokemonsStateProvider.notifier).build(),
                sliver: true,
              ),
        ],
      ),
    );
  }
}
