import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'failure.dart';

class CapturedBloc extends StateManagement {
  final PokemonRepository _repository;

  CapturedBloc({
    required PokemonRepository repository,
  })  : _repository = repository{
    on<Invoke<NoParams>>(_getFavorites);
  }

  _getFavorites(Invoke<NoParams> event, Emitter<RequestState> emit) async {
    try {
      emit(LOADING(message: "Obteniendo favoritos"));
      final failureOrSuccess = await _repository.getAllFavorites();
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (movies) => emit(SUCCESS<List<IPokemon>>(data: movies)));
    } catch (e, s) {
      final ex = CapturedBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
