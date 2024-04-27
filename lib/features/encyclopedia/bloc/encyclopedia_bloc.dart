import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/failure.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';


class EncyclopediaBloc extends StateManagement {
  final RequestPokemonsUsecase _useCase;

  EncyclopediaBloc({
    required RequestPokemonsUsecase usecase,
  }) : _useCase = usecase {
    on<Invoke<RequestAllParam>>(_getEncyclopedia);
  }

  _getEncyclopedia(
      Invoke<RequestAllParam> event, Emitter<RequestState> emit) async {
    try {
      emit(LOADING());
      final params = event.params;
      final failureOrSuccess = await _useCase(params);
      return failureOrSuccess.fold(
          (failure) => emit(ERROR(failure: failure)),
          (data) => emit(SUCCESS<List<IPokemonEntry>>(data: data)));
    } catch (e, s) {
      final ex = EncyclopediaBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
