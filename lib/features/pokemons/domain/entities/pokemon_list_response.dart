import 'package:freezed_annotation/freezed_annotation.dart';

import 'pokemon.dart';

part 'pokemon_list_response.freezed.dart';

@freezed
class PokemonListResponse with _$PokemonListResponse {
  const factory PokemonListResponse({
    required final int maxCount,
    required final List<PokemonResult> results,
  }) = _PokemonListResponse;
}
