import 'package:flutter_pokedex/features/encyclopedia/bloc/popular_movies_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<EncyclopediaBloc>(
      () => EncyclopediaBloc(repository: sl()));
}
