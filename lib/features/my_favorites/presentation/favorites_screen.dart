import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: MaterialButton(
          onPressed: () => context.push('/pokemon/1'),
          child: const Text('Go to details'),
        ),
      ),
    );
  }
}
