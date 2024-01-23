import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/presentation/riverpod_extensions.dart';
import '../widgets/pokemons_sliver_grid.dart';
import 'fetched_pokemons_state.dart';

class FetchedPokemonsScreen extends ConsumerStatefulWidget {
  const FetchedPokemonsScreen({super.key});

  @override
  ConsumerState<FetchedPokemonsScreen> createState() => _PokemonsScreenState();
}

class _PokemonsScreenState extends ConsumerState<FetchedPokemonsScreen> {
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fetchedPokemonsStateProvider);
    return Scaffold(
      backgroundColor: Colors.green,
      body: CustomScrollView(
        key: const Key('fetched-pokemons-screen'),
        controller: _controller,
        slivers: [
          SliverAppBar(
            title: const Text('Pokedex'),
            titleTextStyle: Theme.of(context).textTheme.displayMedium,
            centerTitle: false,
            expandedHeight: 100,
            floating: false,
            pinned: true,
          ),
          state.renderWhen(
            (data) => PokemonsSliverGrid(data.pokemonResults),
            onRetry: () =>
                ref.read(fetchedPokemonsStateProvider.notifier).build(),
            sliver: true,
          ),
        ],
      ),
    );
  }

  /// Requests more pokemons when the user is close to the bottom of the list
  void _scrollListener() {
    if (_controller.position.extentAfter < 500) {
      ref.read(fetchedPokemonsStateProvider.notifier).loadMore();
    }
  }
}
