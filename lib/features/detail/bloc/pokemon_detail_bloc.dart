import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'failure.dart';

class PokemonDetailBloc extends StateManagement {
  final PokemonRepository _repository;
  final AddFavoriteUseCase _useCase;

  PokemonDetailBloc({
    required PokemonRepository repository,
    required AddFavoriteUseCase useCase,
  })  : _repository = repository,
        _useCase = useCase {
    on<Invoke<RequestParam>>(_getPokemonFromId);
    on<Invoke<GetFavorite>>(_getFavoriteMoveFromId);
    on<Invoke<AddFavorite>>(_addToFavorites);
    on<Invoke<DeleteFavorite>>(_removeFromFavorites);
    on<Invoke<CheckIsFavorite>>(_checkFavoriteMoveFromId);
  }

  _getPokemonFromId(
      Invoke<RequestParam> event, Emitter<RequestState> emit) async {
    try {
      final id = event.params.id;
      emit(LOADING(message: "Obteniendo pokemon"));
      final failureOrSuccess = await _repository.getPokemonDetail(id);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (data) => emit(SUCCESS<IPokemon>(data: data)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _getFavoriteMoveFromId(
      Invoke<GetFavorite> event, Emitter<RequestState> emit) async {
    try {
      final id = event.params.id;
      emit(LOADING(message: "Obteniendo pokemon capturado"));
      final failureOrSuccess = await _repository.getFavoritePokemon(id);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (data) => emit(SUCCESS<IPokemon>(data: data)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _checkFavoriteMoveFromId(
      Invoke<CheckIsFavorite> event, Emitter<RequestState> emit) async {
    try {
      final id = event.params.id;
      emit(LOADING(message: "Verificando"));
      final failureOrSuccess = await _repository.getFavoriteStatus(id);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (data) => emit(SUCCESS<bool>(data: data)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _addToFavorites(Invoke<AddFavorite> event, Emitter<RequestState> emit) async {
    try {
      final IPokemon pokemon = event.params.pokemon;
      emit(LOADING(message: "Capturando pokemon ..."));
      final failureOrSuccess = await _useCase(pokemon);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (isSuccess) => emit(SUCCESS<bool>(data: isSuccess)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  _removeFromFavorites(
      Invoke<DeleteFavorite> event, Emitter<RequestState> emit) async {
    try {
      final params = event.params.id;
      emit(LOADING(message: "Removiendo favorito"));
      final failureOrSuccess = await _repository.deleteFromFavorite(params);
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (isFavorite) => emit(SUCCESS<bool>(data: !isFavorite)));
    } catch (e, s) {
      final ex = DetailBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
