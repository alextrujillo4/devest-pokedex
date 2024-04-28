import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'extension.dart';

class MockEncyclopediaBloc extends MockBloc<RequestEvent, RequestState>
    implements EncyclopediaBloc {}

class MockRequestPokedexUsecase extends Mock implements RequestPokedexUsecase {
  @override
  Future<Either<Failure, List<IPokemonEntry>>> call(
    PokedexParams params,
  ) {
    return Future(() => Right([mockPokemonEntry()]));
  }
}

class MockErrorRequestPokedexUsecase extends Mock
    implements RequestPokedexUsecase {
  @override
  Future<Either<Failure, List<IPokemonEntry>>> call(
    PokedexParams params,
  ) {
    return Future(() => Left(
        ParseFailure(message: "some_message", stacktrace: StackTrace.current)));
  }
}

void main() {
  group('EncyclopediaBloc GetAllFavorites Tests', () {
    final mockRequestPokedexUsecase = MockRequestPokedexUsecase();
    blocTest(
      'emits [LOADING, SUCCESS], when Invoke(PokedexParams) is Success',
      build: () => EncyclopediaBloc(usecase: mockRequestPokedexUsecase),
      act: (bloc) => bloc.add(Invoke(params: PokedexParams(region: "region"))),
      expect: () => [
        isA<LOADING>(),
        isA<SUCCESS<List<IPokemonEntry>>>()
            .having((event) => event.data.length, "length", 1)
      ],
    );

    final errorRequestPokedexUsecase = MockErrorRequestPokedexUsecase();
    blocTest(
      'emits [LOADING, ERROR], when Invoke(PokedexParams) is Error',
      build: () => EncyclopediaBloc(usecase: errorRequestPokedexUsecase),
      act: (bloc) => bloc.add(Invoke(params: PokedexParams(region: "region"))),
      expect: () => [
        isA<LOADING>(),
        isA<ERROR>()
            .having((event) => event.failure.message, "message", "some_message")
      ],
    );
  });
}
