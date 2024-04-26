import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/failure.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';


class EncyclopediaBloc extends StateManagement {
  final PokedexRepository _repository;

  EncyclopediaBloc({
    required PokedexRepository repository,
  }) : _repository = repository {
    on<Invoke<String>>(_getEncyclopedia);
  }

  _getEncyclopedia(
      Invoke<String> event, Emitter<RequestState> emit) async {
    try {
      emit(LOADING());
      final params = event.params;
      final failureOrSuccess = await _repository.getPokedexByRegion(params);
      return failureOrSuccess.fold(
          (failure) => emit(ERROR(failure: failure)),
          (data) =>
              emit(SUCCESS<IPokedex>(data: data)));
    } catch (e, s) {
      final ex = EncyclopediaBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }
}
