import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'extension.dart';

class MockCapturedBloc extends MockBloc<RequestEvent, RequestState>
    implements CapturedBloc {}

class MockRequestCapturedPokemonsUsecase extends Mock
    implements RequestCapturedPokemonsUsecase {
  @override
  Future<Either<Failure, List<IPokemon>>> call(
    GetFavoritesParams params,
  ) {
    return Future(() => Right([mockPokemon()]));
  }
}

class MockErrorRequestCapturedPokemonsUsecase extends Mock
    implements RequestCapturedPokemonsUsecase {
  @override
  Future<Either<Failure, List<IPokemon>>> call(
    GetFavoritesParams params,
  ) {
    return Future(() => Left(
        ParseFailure(message: "some_message", stacktrace: StackTrace.current)));
  }
}

class MockErrorPokemonRepository extends Mock implements PokemonRepository {
  @override
  Future<Either<Failure, List<IPokemon>>> getAllFavorites() {
    return Future(
      () => Left(ParseFailure(
          message: "some_message", stacktrace: StackTrace.current)),
    );
  }

  @override
  Future<Either<Failure, IPokemon>> getFavoritePokemon(int id) {
    return Future(() => Left(
        ParseFailure(message: "some_message", stacktrace: StackTrace.current)));
  }

  @override
  Future<Either<Failure, bool>> deleteFromFavorite(int id) {
    return Future(() => const Right(false));
  }

  @override
  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon) {
    return Future(() => const Right(false));
  }
}

void main() {
  group('CapturedBloc GetAllFavorites Tests', () {
    final mockRequestCapturedPokemonsUsecase =
        MockRequestCapturedPokemonsUsecase();
    blocTest(
      'emits [LOADING, SUCCESS], when Invoke(GetFavoritesParams) is Success',
      build: () => CapturedBloc(useCase: mockRequestCapturedPokemonsUsecase),
      act: (bloc) => bloc.add(Invoke(params: GetFavoritesParams())),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<(List<IPokemon>, String)>>()
            .having((event) => event.data.$1.length, "length", 1)
            .having((event) => event.data.$2, "type", "name")
      ],
    );

    final errorRequestCapturedPokemonsUsecase =
        MockErrorRequestCapturedPokemonsUsecase();
    blocTest(
      'emits [LOADING, ERROR], when Invoke(GetFavoritesParams) is Error',
      build: () => CapturedBloc(useCase: errorRequestCapturedPokemonsUsecase),
      act: (bloc) => bloc.add(Invoke(params: GetFavoritesParams())),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });
}
