import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/core/data/local_config.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/features/pokemons/data/data_sources/pokedex_local_service.dart';

import '../../../../test_utils/model_factory.dart';

void main() {
  late PokedexDatabase database;
  late PokedexLocalService pokedexLocalService;

  setUp(() {
    database = PokedexDatabase(NativeDatabase.memory());
    pokedexLocalService = PokedexLocalService(database);
  });

  tearDown(() => database.close());

  group('pokedex local service', () {
    test('should save pokemon', () async {
      final pokemon = createDetailedPokemonModel();

      final result = await pokedexLocalService.savePokemon(pokemon);

      expect(result, 1);
    });

    test('should get all saved pokemons', () async {
      final pokemon1 = createDetailedPokemonModel();
      final pokemon2 = createDetailedPokemonModel(id: 2);

      await pokedexLocalService.savePokemon(pokemon1);
      await pokedexLocalService.savePokemon(pokemon2);

      final result = await pokedexLocalService.getAllSavedPokemons();

      expect(result, [pokemon1, pokemon2]);
    });

    test('should delete pokemon', () async {
      final pokemon = createDetailedPokemonModel();

      await pokedexLocalService.savePokemon(pokemon);

      var result = await pokedexLocalService.getAllSavedPokemons();

      expect(result, isNotEmpty);

      final deleteResult = await pokedexLocalService.deletePokemon(pokemonId);

      expect(deleteResult, false);

      result = await pokedexLocalService.getAllSavedPokemons();

      expect(result, isEmpty);
    });
  });
}
