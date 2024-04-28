import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/domain/repository/pokedex_repository.dart';

import 'extension.dart';

class MockPokedexRepository extends Mock implements PokedexRepository {
  @override
  Future<Either<Failure, IPokedex>> getPokedexByRegion(String region) {
    return Future(() => Right(mockPokedex()));
  }
}

class MockErrorPokedexRepository extends Mock implements PokedexRepository {
  @override
  Future<Either<Failure, IPokedex>> getPokedexByRegion(String region) {
    return Future(() =>
        Left(ParseFailure(message: "Pokedex ParseFailure", stacktrace: null)));
  }
}

void main() {
  late RequestPokedexUsecase useCase;
  late PokedexRepository mockRepository;
  late MockErrorPokedexRepository mockErrorPokedexRepository;

  setUp(() {
    mockRepository = MockPokedexRepository();
    mockErrorPokedexRepository = MockErrorPokedexRepository();
  });

  test('RequestPokedexUsecase should add a pokedex to favorites successfully',
      () async {
    useCase = RequestPokedexUsecase(mockRepository);
    final result = await useCase(PokedexParams(region: 'Region'));

    expect(
        result,
        isA<Right>().having((event) => event.value.runtimeType, 'runtimeType',
            List<PokemonEntry>));
  });

  test(
      'RequestPokedexUsecase should return a failure when adding pokedex fails',
      () async {
    useCase = RequestPokedexUsecase(mockErrorPokedexRepository);

    final result = await useCase(PokedexParams(region: 'Region'));
    expect(
        result,
        isA<Left>().having(
            (event) => event.value.runtimeType, 'runtimeType', ParseFailure));
  });

  test(
      'RequestPokedexUsecase and add a query should return a pokedex when filtered by query name',
      () async {
    useCase = RequestPokedexUsecase(mockRepository);
    final result = await useCase(PokedexParams(region: 'Region', query: "cha"));

    final rightValue = result as Right;
    expect((rightValue.value as List<IPokemonEntry>).length, 2);
  });

  test(
      'RequestPokedexUsecase and add a empty query should return a all the pokedex',
      () async {
    useCase = RequestPokedexUsecase(mockRepository);
    final result = await useCase(PokedexParams(region: 'Region', query: ""));

    final rightValue = result as Right;
    expect((rightValue.value as List<IPokemonEntry>).length, 3);
  });
}
