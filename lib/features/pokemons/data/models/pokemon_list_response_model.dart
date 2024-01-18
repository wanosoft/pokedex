import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon_list_response.dart';
import 'pokemon_result_model.dart';

part 'pokemon_list_response_model.freezed.dart';
part 'pokemon_list_response_model.g.dart';

@freezed
class PokemonListResponseModel with _$PokemonListResponseModel {
  const PokemonListResponseModel._();

  const factory PokemonListResponseModel({
    @JsonKey(name: 'count') required final int maxCount,
    required final List<PokemonResultModel> results,
  }) = _PokemonListResponseModel;

  factory PokemonListResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonListResponseModelFromJson(json);

  PokemonListResponse toPokemonListResponse() => PokemonListResponse(
        maxCount: maxCount,
        results: results.map((e) => e.toPokemonResult()).toList(),
      );
}
