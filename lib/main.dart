import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/constants/app_colors.dart';
import 'package:flutter_pokedex/common/constants/app_strings.dart';
import 'package:flutter_pokedex/common/constants/theme.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:network/di.dart' as network;
import 'package:pokedex/di.dart' as pokedex;
import 'package:pokedex/pokedex_package.dart';
import 'package:pokemon/di.dart' as pokemon;
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';
import 'package:storage/di.dart' as storage;

import 'common/constants/app_routes.dart';
import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await network.init();
  await storage.init();
  await pokemon.init();
  await pokedex.init();
  await init();
  runApp(const PokedexApp());
}

class PokedexApp extends StatelessWidget {
  const PokedexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => sl<EncyclopediaBloc>()
            ..add(
              Invoke(
                params: PokedexParams(region: "kanto"),
              ),
            ),
        ),
        BlocProvider(
            create: (_) => sl<CapturedBloc>()
              ..add(Invoke(params: GetFavoritesParams()))),
      ],
      child: BlocBuilder<CapturedBloc, RequestState>(
        builder: (context, state) {
          var primaryColor = AppColors.bostonUniversityRed;
          if (state is SUCCESS<(List<IPokemon>, String)>) {
            final predominant = state.data.$2;
            primaryColor = AppColors.getPokemonColorType[predominant] ??
                AppColors.bostonUniversityRed;
          }
          return MaterialApp.router(
            title: AppStrings.appBarTitle,
            routerConfig: appRouter,
            theme: appTheme(primaryColor),
          );
        },
      ),
    );
  }
}
