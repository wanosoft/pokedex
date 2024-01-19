import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/data/models/detailed_pokemon_model.dart';

import '../../../../test_utils/entity_factory.dart';
import '../../../../test_utils/model_factory.dart';

void main() {
  group('detailed pokemon model should map', () {
    test('from json', () {
      final model = DetailedPokemonModel.fromJson(getPokemonDetailsJson);

      expect(model, isA<DetailedPokemonModel>());
    });

    test('to entity', () {
      final model = createDetailedPokemonModel();
      final expected = createDetailedPokemon();

      expect(model.toDetailedPokemon(), expected);
    });
  });
}
