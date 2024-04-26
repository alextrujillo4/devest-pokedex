import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/data/datasource/local_data_source.dart';
import 'package:pokemon/src/data/datasource/remote_data_source.dart';
import 'package:pokemon/src/data/repository/repository_impl.dart';
import 'package:pokemon/src/domain/entity/pokemon.dart';
import 'domain_test.mocks.dart';
import 'extension.dart';


@GenerateMocks([PokemonRemoteDatasource, PokemonLocalDatasource])
void main() {
  const id = 151;

  group("Pokemon:Domain Package Test", () {
    late PokemonRemoteDatasource remoteDatasource;
    late PokemonLocalDatasource localDatasource;
    late PokemonRepository repository;

    setUp(() {
      remoteDatasource = MockPokemonRemoteDatasource();
      localDatasource = MockPokemonLocalDatasource();
      repository = PokemonRepositoryImpl(
          remoteDataSource: remoteDatasource, localDatasource: localDatasource);
    });

    test(
        'When requestGetPokemonDetail is performed successfully, Then repository return a Right',
        () async {
      var aliasResolver = mockPokemon();
      when(remoteDatasource.requestPokemonDetail(id))
          .thenAnswer((_) async => aliasResolver);

      final data = await repository.getPokemonDetail(id);

      expect(
          data,
          isA<Right>().having(
              (event) => event.value.runtimeType, 'runtimeType', Pokemon));
    });

    test(
        'When requestGetPokemonDetail is performed, But Failure thrown, Then repository return a Left',
        () async {
      when(remoteDatasource.requestPokemonDetail(id))
          .thenThrow(ParseFailure(message: "some_message"));

      final data = await repository.getPokemonDetail(id);
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
