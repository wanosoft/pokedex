import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';
import 'package:pokedex/features/pokemons/domain/use_cases/fetch_and_save_detailed_pokemon_use_case.dart';

class VoidCallBack {
  void call() {}
}

class MockVoidCallBack extends Mock implements VoidCallBack {}


class MockPokedexRepository extends Mock implements PokedexRepository {}

class MockFetchAndSaveDetailedPokemonUseCase extends Mock
    implements FetchAndSaveDetailedPokemonUseCase {}
