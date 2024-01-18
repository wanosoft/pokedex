import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PokemonsScreen extends StatelessWidget {
  const PokemonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: MaterialButton(
          onPressed: () => context.push('/pokemon/1'),
          child: const Text('Go to details'),
        ),
      ),
    );
  }
}
