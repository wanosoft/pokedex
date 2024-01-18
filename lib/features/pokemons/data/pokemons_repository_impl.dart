import '../../../core/domain/entities/failure.dart';
import '../domain/entities/pokemon_list_response.dart';
import '../domain/pokedex_repository.dart';
import 'data_sources/pokedex_remote_service.dart';

class PokemonsRepositoryImpl extends PokedexRepository {
  PokemonsRepositoryImpl({required this.remoteService});

  final PokedexRemoteService remoteService;

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
}
