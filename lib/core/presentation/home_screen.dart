import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: const [
          // TODO: Change the icons
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pokemons',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }

  void _onTap(int value) {
    if (value == 0) {
      context.go(PokedexRoutes.pokemons.path);
    } else {
      context.go(PokedexRoutes.favorites.path);
    }

    setState(() => _currentIndex = value);
  }
}
