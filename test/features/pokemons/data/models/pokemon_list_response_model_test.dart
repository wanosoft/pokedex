import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_list_response_model.dart';

import '../../../../test_utils/entity_factory.dart';
import '../../../../test_utils/model_factory.dart';

void main() {
  group('pokemon list response model should map', () {
    test('from json', () {
      final model = PokemonListResponseModel.fromJson(pokemonListReponseJson);

      expect(model, isA<PokemonListResponseModel>());
    });

    test('to entity', () {
      final model = createPokemonListResponseModel();
      final expected = createPokemonListResponse();

      expect(model.toPokemonListResponse(), expected);
    });
  });
}
