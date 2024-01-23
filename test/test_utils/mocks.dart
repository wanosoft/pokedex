import 'package:mocktail/mocktail.dart';
import 'package:pokedex/features/pokemons/domain/pokedex_repository.dart';

class VoidCallBack {
  void call() {}
}

class MockVoidCallBack extends Mock implements VoidCallBack {}


class MockPokedexRepository extends Mock implements PokedexRepository {}
