import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_list_response.freezed.dart';

@freezed
class PokemonListResponse with _$PokemonListResponse {
  const factory PokemonListResponse({
    required final int maxCount,
    required final List<PokemonResult> results,
  }) = _PokemonListResponse;
}

@freezed
class PokemonResult with _$PokemonResult {
  const factory PokemonResult({
    required String id,
    required String name,
  }) = _PokemonResult;
}
