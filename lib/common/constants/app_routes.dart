import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:flutter_pokedex/features/captured/page/captured_page.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/detail/page/detail_page.dart';
import 'package:flutter_pokedex/features/encyclopedia/page/encyclopedia_page.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import '../../di.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/",
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const EncyclopediaPage();
      },
      routes: <RouteBase>[
        GoRoute(
          path: 'captured',
          builder: (BuildContext context, GoRouterState state) {
            context
                .read<CapturedBloc>()
                .add(Invoke(params: GetAllFavoritesParams()));
            return const CapturedPage();
          },
        ),
        GoRoute(
          path: 'pokemon/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.parse(state.pathParameters["id"]!);
            print("Pokemon is: $id");
            return DetailPage(
              bloc: sl<PokemonDetailBloc>()
                ..add(Invoke(params: RequestParam(id: id))),
              selectedPokemonId: id,
            );
          },
        ),
        GoRoute(
          path: 'detail/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.parse(state.pathParameters["id"]!);
            print("Pokemon is: $id");
            return DetailPage(
              bloc: sl<PokemonDetailBloc>()
                ..add(Invoke(params: GetFavorite(id: id))),
              selectedPokemonId: id,
            );
          },
        ),
      ],
    ),
  ],
);
