import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/pokemon_result.dart';

part 'pokemon_result_model.freezed.dart';
part 'pokemon_result_model.g.dart';

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
  String get id => url.split('/').reversed.elementAt(1);

  /// TODO: Move this extension to presentation layer
  String get imageUrl =>
      'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png';
}
