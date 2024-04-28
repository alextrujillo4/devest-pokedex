import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/data/datasource/remote_data_source.dart';
import 'package:pokedex/src/data/repository/pokedex_repository_impl.dart';
import 'package:pokedex/src/domain/repository/pokedex_repository.dart';
import 'pokedex_domain_test.mocks.dart';

class MockPokedex extends Mock implements Pokedex {}

@GenerateMocks([PokedexRemoteDataSource])
void main() {
  const REGION = "kanto";
  group("Pokedex:Domain Package Test", () {
    late PokedexRemoteDataSource remoteDatasource;
    late PokedexRepository repository;

    setUp(() {
      remoteDatasource = MockPokedexRemoteDataSource();
      repository =
          PokedexRepositoryImpl(remoteDataSource: remoteDatasource);
    });

    test(
        'When getPokedex is performed successfully, Then repository return a Right',
        () async {
      when(remoteDatasource.requestPokedexByRegion(REGION))
          .thenAnswer((_) async => MockPokedex());

      final data = await repository.getPokedexByRegion(REGION);

      expect(
          data,
          isA<Right>().having((event) => event.value.runtimeType, 'runtimeType',
              MockPokedex));
    });

    test(
        'When getPokedex is performed, But Failure thrown, Then repository return a Left',
        () async {

      when(remoteDatasource.requestPokedexByRegion(REGION))
          .thenThrow(ParseFailure(message: "some_message"));

      final data = await repository.getPokedexByRegion(REGION);

      expect(
          data,
          isA<Left>().having(
              (event) => event.value.runtimeType, 'runtimeType', ParseFailure));
      expect(
          data,
          isA<Left>().having(
              (event) => event.value.message, 'message', "some_message"));
    });
  });
}
