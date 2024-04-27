import 'package:audioplayers/audioplayers.dart';
import 'package:flowery_tts/flowery_tts.dart';
import 'package:flutter_pokedex/common/settings_provider.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerSingleton<SettingsProvider>(SettingsProvider());

  sl.registerLazySingleton(() => const Flowery());

  sl.registerLazySingleton(() => AudioPlayer());

  sl.registerFactory<EncyclopediaBloc>(
      () => EncyclopediaBloc(repository: sl()));

  sl.registerFactory<CapturedBloc>(() => CapturedBloc(repository: sl()));

  sl.registerFactory<PokemonDetailBloc>(
      () => PokemonDetailBloc(repository: sl(), useCase: sl()));
}
