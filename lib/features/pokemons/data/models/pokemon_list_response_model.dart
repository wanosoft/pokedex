import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon.dart';
import '../../domain/entities/pokemon_list_response.dart';

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

@freezed
class PokemonResultModel with _$PokemonResultModel {
  const PokemonResultModel._();

  const factory PokemonResultModel({
    required String name,
    required String url,
  }) = _PokemonResultModel;

  factory PokemonResultModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonResultModelFromJson(json);

  PokemonResult toPokemonResult() => PokemonResult(id: id, name: name);
}

extension PokemonModelX on PokemonResultModel {
  int get id => int.parse(url.split('/').reversed.elementAt(1));
}
