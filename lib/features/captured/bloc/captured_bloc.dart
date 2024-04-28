import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'failure.dart';

class CapturedBloc extends StateManagement {
  final PokemonRepository _repository;

  CapturedBloc({
    required PokemonRepository repository,
  }) : _repository = repository {
    on<Invoke<NoParams>>(_getFavorites);
  }

  _getFavorites(Invoke<NoParams> event, Emitter<RequestState> emit) async {
    try {
      emit(LOADING(message: "Obteniendo favoritos"));
      final failureOrSuccess = await _repository.getAllFavorites();
      return failureOrSuccess.fold((failure) => emit(ERROR(failure: failure)),
          (pokemons) {
        final typeCounts = _countPokemonTypes(pokemons);
        final dominantType = _findDominantType(typeCounts);
        return emit(SUCCESS<(List<IPokemon>, String)>(
            data: (pokemons, dominantType ?? "default")));
      });
    } catch (e, s) {
      final ex = CapturedBlocFailure(message: "$e", stacktrace: s);
      emit(ERROR(failure: ex));
    }
  }

  Map<String, int> _countPokemonTypes(List<IPokemon> pokemons) {
    final typeCount = <String, int>{};
    for (final pokemon in pokemons) {
      for (final type in pokemon.types) {
        typeCount.update(type.name, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    return typeCount;
  }

  String? _findDominantType(Map<String, int> typeCounts) {
    if (typeCounts.isEmpty) {
      return null;
    }
    int maxValue = typeCounts.entries.first.value;
    String dominantType = typeCounts.entries.first.key;

    for (final entry in typeCounts.entries) {
      if (entry.value > maxValue) {
        maxValue = entry.value;
        dominantType = entry.key;
      }
    }
    var repeated = 0;
    for (final entry in typeCounts.entries) {
      if (entry.value == maxValue) {
        repeated++;
      }
    }
    return (repeated > 1) ? null : dominantType;
  }
}
