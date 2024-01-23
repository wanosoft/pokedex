import 'dart:convert';
import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/pokemons/data/models/detailed_pokemon_model.dart';

part 'local_config.g.dart';

typedef GetDocumentsDirectory = Future<Directory> Function();

@Riverpod(keepAlive: true)
GetDocumentsDirectory getDocumentsDirectory(GetDocumentsDirectoryRef ref) =>
    getApplicationDocumentsDirectory;

@Riverpod(keepAlive: true)
QueryExecutor queryExecutor(QueryExecutorRef ref) {
  final getDocumentsDirectory = ref.watch(getDocumentsDirectoryProvider);

  return LazyDatabase(() async {
    final dbFolder = await getDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file, logStatements: kDebugMode);
  });
}

@Riverpod(keepAlive: true)
PokedexDatabase pokedexDatabase(PokedexDatabaseRef ref) {
  final queryExecutor = ref.watch(queryExecutorProvider);
  return PokedexDatabase(queryExecutor);
}

@DriftDatabase(tables: [LocalPokemon])
class PokedexDatabase extends _$PokedexDatabase {
  PokedexDatabase(super.e);

  @override
  int get schemaVersion => 1;
}

/// Pokemon table definition, used to save pokemons in local storage.
class LocalPokemon extends Table {
  @override
  Set<Column<Object>>? get primaryKey => {id};
  IntColumn get id => integer()();
  TextColumn get name => text()();
  IntColumn get height => integer()();
  IntColumn get weight => integer()();
  TextColumn get types => text().map(PokemonTypesConverter())();
  TextColumn get moves => text().map(PokemonMovesConverter())();
  TextColumn get stats => text().map(PokemonStatsConverter())();
}

class PokemonTypesConverter
    extends TypeConverter<List<PokemonTypeModel>, String> {
  @override
  List<PokemonTypeModel> fromSql(String fromDb) {
    return fromDb
        .split(',')
        .map(
          (string) => PokemonTypeModel.values.firstWhere(
            (type) => type.name == string,
          ),
        )
        .toList();
  }

  @override
  String toSql(List<PokemonTypeModel> value) {
    return value.map((e) => e.name).join(',');
  }
}

class PokemonMovesConverter extends TypeConverter<List<String>, String> {
  @override
  List<String> fromSql(String fromDb) {
    return fromDb.split(',');
  }

  @override
  String toSql(List<String> value) {
    return value.join(',');
  }
}

class PokemonStatsConverter
    extends TypeConverter<List<PokemonStatModel>, String> {
  final separator = '-------separator-------';

  @override
  List<PokemonStatModel> fromSql(String fromDb) {
    return fromDb
        .split(separator)
        .map(
          (string) => PokemonStatModel.fromJson(
            jsonDecode(string) as Map<String, dynamic>,
          ),
        )
        .toList();
  }

  @override
  String toSql(List<PokemonStatModel> value) {
    return value.map((e) => jsonEncode(e.toJson())).join(separator);
  }
}
