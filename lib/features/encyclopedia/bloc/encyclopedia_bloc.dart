import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/failure.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';


class EncyclopediaBloc extends StateManagement {
  final RequestPokedexUsecase _useCase;

  EncyclopediaBloc({
    required RequestPokedexUsecase usecase,
  }) : _useCase = usecase {
    on<Invoke<PokedexParams>>(_getEncyclopedia);
  }

  _getEncyclopedia(
      Invoke<PokedexParams> event, Emitter<RequestState> emit) async {
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
