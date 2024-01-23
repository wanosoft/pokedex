import '../../../core/domain/entities/failure.dart';
import '../domain/entities/pokemon.dart';
import '../domain/entities/pokemon_list_response.dart';
import '../domain/pokedex_repository.dart';
import 'data_sources/pokedex_local_service.dart';
import 'data_sources/pokedex_remote_service.dart';
import 'models/detailed_pokemon_model.dart';

class PokemonsRepositoryImpl extends PokedexRepository {
  PokemonsRepositoryImpl({
    required this.remoteService,
    required this.localService,
  });

  final PokedexRemoteService remoteService;
  final PokedexLocalService localService;

  @override
  Future<PokemonListResponse> getPokemonList({
    required int offset,
    int limit = 25,
  }) async {
    try {
      final response = await remoteService.getPokemonList(
        offset: offset,
        limit: limit,
      );
      return response.toPokemonListResponse();
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<DetailedPokemon> getPokemonDetailsById(int id) async {
    try {
      final response = await remoteService.getPokemonDetailsById(id);
      return response.toDetailedPokemon();
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<bool> deletePokemon(int pokemonId) async {
    try {
      return await localService.deletePokemon(pokemonId);
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<List<DetailedPokemon>> getAllSavedPokemons() async {
    try {
      final models = await localService.getAllSavedPokemons();
      return models.map((e) => e.toDetailedPokemon()).toList();
    } catch (e) {
      throw Failure.fromException(e);
    }
  }

  @override
  Future<int> savePokemon(DetailedPokemon pokemon) async {
    try {
      return localService.savePokemon(
        DetailedPokemonModel.fromDetailedPokemon(pokemon),
      );
    } catch (e) {
      throw Failure.fromException(e);
    }
  }
}
