import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/data/datasource/remote_data_source.dart';

import 'pokedex_data_test.mocks.dart';


@GenerateMocks([HttpInterceptor, http.Response])
void main() {
  final mockDir = "${Directory.current.path}/test/mocks";
  const url = "kanto";

  group('PokedexRemoteDatasourceImpl Tests', () {
    late PokedexRemoteDataSourceImpl
        datasource; // Variable to hold your datasource
    late HttpInterceptor mockHttp;

    setUp(() {
      mockHttp = MockHttpInterceptor();
      datasource = PokedexRemoteDataSourceImpl(http: mockHttp);
    });

    test('should return a Pokemon when JSON parsing is successful', () async {
      final successResponse =
          await File('$mockDir/encyclopedia.json').readAsString();

      when(mockHttp.requestGet(path: url))
          .thenAnswer((_) async => http.Response(
                successResponse,
                200,
              ));

      final result = await datasource.requestPokedexByRegion("kanto");

      verify(mockHttp.requestGet(path: url)).called(1);

      expect(result, isA<IPokedex>());
    });

    test('should throw a ParseFailure when JSON parsing fails', () async {
      final wrongResonse =
          await File('$mockDir/pokedex_wrong.json').readAsString();

      when(mockHttp.requestGet(path: url))
          .thenAnswer((_) async => http.Response(wrongResonse, 200));

      try {
        final result = await datasource.requestPokedexByRegion("kanto");
        expect(result, isA<ParseFailure>());
      } catch (e) {
        expect(e, isA<ParseFailure>());
      }
    });
  });
}
