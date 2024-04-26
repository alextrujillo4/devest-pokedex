import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokemon/src/domain/entity/ipokemon.dart';
import 'package:pokemon/src/domain/entity/pokemon.dart';
import 'package:pokemon/src/domain/repository/repository.dart';
import 'package:pokemon/src/domain/usecase/add_favorite_usecase.dart';

import 'extension.dart';


class MockPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, bool>> addToFavorite(Pokemon pokemon) {
    return Future(() => const Right(true));
  }
}

class MockErrorPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon) {
    return Future(() => Left(ParseFailure(message: "", stacktrace: null)));
  }
}

void main() {
  late AddFavoriteUseCase useCase;
  late MockPokemonRepository mockRepository;
  late MockErrorPokemonRepository mockErrorPokemonRepository;

  setUp(() {
    mockRepository = MockPokemonRepository();
    mockErrorPokemonRepository = MockErrorPokemonRepository();
  });

  test('AddFavoriteUseCase should add a pokemon to favorites successfully',
      () async {
    useCase = AddFavoriteUseCase(mockRepository);
    final pokemon = mockPokemon();
    final result = await useCase(pokemon);

    expect(result, isA<Right>());
  });

  test('AddFavoriteUseCase should return a failure when adding pokemon fails',
      () async {
    useCase = AddFavoriteUseCase(mockErrorPokemonRepository);
    final pokemon = mockPokemon();

    final result = await useCase.call(pokemon);
    expect(
        result,
        isA<Left>().having(
            (event) => event.value.runtimeType, 'runtimeType', ParseFailure));
  });
}
