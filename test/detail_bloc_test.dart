import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'extension.dart';

class MockPokemonDetailBloc extends MockBloc<RequestEvent, RequestState>
    implements PokemonDetailBloc {}

class MockPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, IPokemon>> getPokemonDetail(int id) {
    return Future(() => Right(mockPokemon()));
  }

  @override
  Future<Either<Failure, List<IPokemon>>> getAllFavorites() {
    return Future(() => Right([mockPokemon()]));
  }

  @override
  Future<Either<Failure, IPokemon>> getFavoritePokemon(int id) {
    return Future(() => Right(mockPokemon()));
  }

  @override
  Future<Either<Failure, bool>> deleteFromFavorite(int id) {
    return Future(() => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon) {
    return Future(() => const Right(true));
  }

  @override
  Future<Either<Failure, bool>> getFavoriteStatus(int id) {
    return Future(() => const Right(true));
  }
}

class MockErrorPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, IPokemon>> getPokemonDetail(int id) {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, List<IPokemon>>> getAllFavorites() {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, IPokemon>> getFavoritePokemon(int id) {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, bool>> deleteFromFavorite(int id) {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon) {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, bool>> getFavoriteStatus(int id) {
    return Future(() => Left(ApiCallFailure(
        message: "some_message", stacktrace: StackTrace.current)));
  }
}

void main() {
  group('RequestPokemonParam PokemonDetailBloc Tests', () {
    final successCallRepository = MockPokemonRepository();
    blocTest(
      'emits [LOADING, SUCCESS], when RequestPokemonParam is Success',
      build: () => PokemonDetailBloc(
        repository: successCallRepository,
      ),
      act: (bloc) => bloc.add(Invoke(params: RequestPokemonParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<IPokemon>>()
            .having((event) => event.data.name, "name", "some-name")
      ],
    );

    final errorCallRepository = MockErrorPokemonRepository();
    blocTest(
      'emits [LOADING, ERROR], when RequestPokemonParam is Error',
      build: () => PokemonDetailBloc(repository: errorCallRepository),
      act: (bloc) => bloc.add(Invoke(params: RequestPokemonParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });

  group('GetFavoriteByIdParam PokemonDetailBloc Tests', () {
    final successCallRepository = MockPokemonRepository();
    blocTest(
      'emits [LOADING, SUCCESS], when GetFavoriteByIdParam is Success',
      build: () => PokemonDetailBloc(
        repository: successCallRepository,
      ),
      act: (bloc) => bloc.add(Invoke(params: GetFavoriteByIdParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<IPokemon>>()
            .having((event) => event.data.name, "name", "some-name")
      ],
    );

    final errorCallRepository = MockErrorPokemonRepository();
    blocTest(
      'emits [LOADING, ERROR], when GetFavoriteByIdParam is Error',
      build: () => PokemonDetailBloc(repository: errorCallRepository),
      act: (bloc) => bloc.add(Invoke(params: GetFavoriteByIdParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });

  group('AddToFavoriteParam PokemonDetailBloc Tests', () {
    final successCallRepository = MockPokemonRepository();
    blocTest(
      'emits [LOADING, SUCCESS], when AddToFavoriteParam is Success',
      build: () => PokemonDetailBloc(
        repository: successCallRepository,
      ),
      act: (bloc) =>
          bloc.add(Invoke(params: AddToFavoriteParam(pokemon: mockPokemon()))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<bool>>().having((event) => event.data, "status", true)
      ],
    );

    final errorCallRepository = MockErrorPokemonRepository();
    blocTest(
      'emits [LOADING, ERROR], when AddToFavoriteParam is Error',
      build: () => PokemonDetailBloc(repository: errorCallRepository),
      act: (bloc) =>
          bloc.add(Invoke(params: AddToFavoriteParam(pokemon: mockPokemon()))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });

  group('DeleteFavoriteParam PokemonDetailBloc Tests', () {
    final successCallRepository = MockPokemonRepository();
    blocTest(
      'emits [LOADING, SUCCESS], when DeleteFavoriteParam is Success',
      build: () => PokemonDetailBloc(
        repository: successCallRepository,
      ),
      act: (bloc) => bloc.add(Invoke(params: DeleteFavoriteParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<bool>>().having((event) => event.data, "status", false)
      ],
    );

    final errorCallRepository = MockErrorPokemonRepository();
    blocTest(
      'emits [LOADING, ERROR], when DeleteFavoriteParam is Error',
      build: () => PokemonDetailBloc(repository: errorCallRepository),
      act: (bloc) => bloc.add(Invoke(params: DeleteFavoriteParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });

  group('CheckIsFavoriteParam PokemonDetailBloc Tests', () {
    final successCallRepository = MockPokemonRepository();
    blocTest(
      'emits [LOADING, SUCCESS], when CheckIsFavoriteParam is Success',
      build: () => PokemonDetailBloc(
        repository: successCallRepository,
      ),
      act: (bloc) => bloc.add(Invoke(params: CheckIsFavoriteParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<bool>>().having((event) => event.data, "status", true)
      ],
    );

    final errorCallRepository = MockErrorPokemonRepository();
    blocTest(
      'emits [LOADING, ERROR], when CheckIsFavoriteParam is Error',
      build: () => PokemonDetailBloc(repository: errorCallRepository),
      act: (bloc) => bloc.add(Invoke(params: CheckIsFavoriteParam(id: 123))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });
}
