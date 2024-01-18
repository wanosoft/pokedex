import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/data/remote_config.dart';
import '../models/pokemon_list_response_model.dart';

part 'pokedex_remote_service.g.dart';

@Riverpod(keepAlive: true)
PokedexRemoteService pokedexRemoteService(PokedexRemoteServiceRef ref) {
  final dio = ref.watch(dioProvider);
  return PokedexRemoteService(dio);
}

@RestApi()
abstract class PokedexRemoteService {
  factory PokedexRemoteService(Dio dio) = _PokedexRemoteService;

  @GET('/pokemon')
  Future<PokemonListResponseModel> getPokemonList({
    @Query('offset') required int offset,
    @Query('limit') int limit = 25,
  });
}
