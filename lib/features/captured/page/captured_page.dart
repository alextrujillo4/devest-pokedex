import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/constants/app_strings.dart';
import 'package:flutter_pokedex/common/widgets/empty_widget.dart';
import 'package:flutter_pokedex/common/widgets/loading_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import '../widget/captured_pokemon_item_widget.dart';

class CapturedPage extends StatelessWidget {
  const CapturedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("detail_page"),
      body: BlocBuilder<CapturedBloc, RequestState>(
        builder: (context, state) {
          if (state is LOADING) {
            return LoadingWidget(message: state.message);
          } else if (state is ERROR) {
            return ProblemWidget(
              title: state.failure.toString(),
              message: state.failure.message,
              onTap: () {
                context
                    .read<CapturedBloc>()
                    .add(Invoke(params: const NoParams()));
              },
            );
          } else if (state is SUCCESS<(List<IPokemon>, String)>) {
            final pokemons = state.data.$1;
            if (pokemons.isEmpty) {
              return const EmptyWidget(message: AppStrings.emptyPokemons);
            }
            return CapturedPokemonsWidget(pokemons: pokemons);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
