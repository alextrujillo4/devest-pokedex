import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokemon/src/data/datasource/local_data_source.dart';
import 'package:pokemon/src/data/datasource/remote_data_source.dart';
import 'package:pokemon/src/domain/entity/pokemon.dart';
import 'package:storage/storage_package.dart';

import 'data_test.mocks.dart';
import 'extension.dart';

@GenerateMocks([HttpInterceptor, http.Response, PokemonLocalDatasource, Storage])
void main() {
  final mockDir = "${Directory.current.path}/test/mocks/";

  group('PokemonRemoteDatasource Tests', () {
    late PokemonRemoteDatasource
        datasource; // Variable to hold your datasource
    late HttpInterceptor mockHttp;

    setUp(() {
      mockHttp = MockHttpInterceptor();
      datasource = PokemonRemoteDatasourceImpl(http: mockHttp);
    });

    test('should return a Pokemon when JSON parsing is successful', () async {
      const pokemonId = 151;
      final successResponse = await File('$mockDir/pokemon.json').readAsString();

      when(mockHttp.requestGet(path: "/pokemon/$pokemonId"))
          .thenAnswer((_) async => http.Response(successResponse, 200));

      final result = await datasource.requestPokemonDetail(pokemonId);

      verify(mockHttp.requestGet(path: "/pokemon/$pokemonId")).called(1);

      expect(result, isA<Pokemon>());
      expect(result.id, 151);
      expect(result.name, "mew");
    });

    test('should throw a ParseFailure when JSON parsing fails', () async {
      const pokemonId = 151;
      final wrongResonse =
          await File('$mockDir/pokemon_wrong.json').readAsString();

      when(mockHttp.requestGet(path: "/pokemon/$pokemonId"))
          .thenAnswer((_) async => http.Response(wrongResonse, 200));

      try {
        final result = await datasource.requestPokemonDetail(pokemonId);
        expect(result, isA<ParseFailure>());
      } catch (e) {
        expect(e, isA<ParseFailure>());
      }
    });
  });

  group('PokemonLocalDatasourceImpl Tests', () {
    late PokemonLocalDatasource dataSource;
    late Storage storage;

    setUp(() {
      storage = MockStorage();
      dataSource = PokemonLocalDatasourceImpl(storage: storage);
    });

    test('When a saving a Pokemon, then favorites contains the Pokemon', () async {
      final mockedPokemon = mockPokemon();
      when(storage.getStringList("POKEMON_KEY")).thenAnswer((_) => []);
      when(storage.setStringList("POKEMON_KEY", [mockedPokemon.toJson()]))
          .thenAnswer((_) async => true);

      final isAdded = await dataSource.addToFavorites(mockedPokemon);

      expect(isAdded, true);
      verify(storage.getStringList("POKEMON_KEY")).called(1);
    });

    test('When a getting a favorites, then return saved elements', () async {
      final mockedPokemon = mockPokemon();
      when(storage.getStringList("POKEMON_KEY"))
          .thenAnswer((_) => [mockedPokemon.toJson()]);

      final listOfElements = await dataSource.getFavorites();

      expect(listOfElements.length, 1);
      verify(storage.getStringList("POKEMON_KEY")).called(1);
    });

    test('When a deleting a favorites By Id, then return true saved elements',
        () async {
      final mockedPokemon = mockPokemon();
      when(storage.getStringList("POKEMON_KEY"))
          .thenAnswer((_) => [mockedPokemon.toJson()]);
      when(storage.setStringList("POKEMON_KEY", [])).thenAnswer((_) async => true);

      final isDeleted = await dataSource.deleteFromFavorites(151);
      expect(isDeleted, true);
      verify(storage.getStringList("POKEMON_KEY")).called(1);
    });
  });
}
