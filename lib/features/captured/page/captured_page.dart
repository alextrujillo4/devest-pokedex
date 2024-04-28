import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/constants/app_strings.dart';
import 'package:flutter_pokedex/common/widgets/empty_widget.dart';
import 'package:flutter_pokedex/common/widgets/loading_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import '../widget/captured_widget.dart';

class CapturedPage extends StatelessWidget {
  const CapturedPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key("detail_page"),
      appBar: AppBar(
        title: const Text("Captured"),
        centerTitle: true,
      ),
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
            return _buildListView(context, pokemons);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildListView(BuildContext context, List<IPokemon> pokemons) {
    return ListView.builder(
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return CapturedPokemonWidget(
          pokemon: pokemon,
          position: index + 1,
        );
      },
    );
  }
}
