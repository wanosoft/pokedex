import 'package:freezed_annotation/freezed_annotation.dart';

part 'pokemon_result.freezed.dart';

@freezed
class PokemonResult with _$PokemonResult {
  const factory PokemonResult({
    required String id,
    required String name,
  }) = _PokemonResult;
}
