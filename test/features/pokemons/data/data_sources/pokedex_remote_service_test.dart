import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:pokedex/core/data/mock_data.dart';
import 'package:pokedex/core/data/remote_config.dart';
import 'package:pokedex/features/pokemons/data/data_sources/pokedex_remote_service.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_list_response_model.dart';
import 'package:pokedex/features/pokemons/data/models/pokemon_result_model.dart';

void main() {
  group('articles service', () {
    late Dio dio;
    late DioAdapter dioAdapter;
    late PokedexRemoteService service;

    setUp(() {
      dio = RemoteConfig.buildDioClient();
      dioAdapter = DioAdapter(dio: dio);
      service = PokedexRemoteService(dio);
    });

    stubDio({
      required String path,
      required Map<String, dynamic> data,
      Map<String, dynamic>? queryParameters,
      int statusCode = 200,
    }) {
      dioAdapter.onGet(
        path,
        (server) => server.reply(statusCode, data),
        queryParameters: queryParameters,
      );
    }

    group('get pokemon list', () {
      test('should return a pokemon list response model', () async {
        stubDio(path: '/pokemon', data: pokemonListReponseJson);

        final response = await service.getPokemonList(offset: 0);

        expect(
          response,
          isA<PokemonListResponseModel>().having(
            (p0) => p0.results,
            'list',
            isA<List<PokemonResultModel>>(),
          ),
        );
      });
    });
  });
}