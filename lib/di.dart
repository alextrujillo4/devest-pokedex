import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<EncyclopediaBloc>(
      () => EncyclopediaBloc(repository: sl()));

  sl.registerFactory<PokemonDetailBloc>(
      () => PokemonDetailBloc(repository: sl(), useCase: sl()));
}
