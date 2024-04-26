import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/widgets/loading_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';

import '../widget/pokemon_entry_widget.dart';

class EncyclopediaPage extends StatelessWidget {
  const EncyclopediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Pokédex Code Challenge'),
      ),
      body: BlocBuilder<EncyclopediaBloc, RequestState>(
        builder: (context, state) {
          if (state is LOADING) {
            return LoadingWidget(message: state.message);
          } else if (state is ERROR) {
            return ProblemWidget(
              title: state.failure.toString(),
              message: state.failure.message,
              onTap: () {
                context.read<EncyclopediaBloc>().add(Invoke(params: "kanto"));
              },
            );
          } else if (state is SUCCESS<IPokedex>) {
            final pokemons = state.data.pokemonEntries;
            return Stack(
              children: [
                _buildGridView(context, pokemons),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _buildGridView(BuildContext context, List<IPokemonEntry> pokemons) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.90,
      ),
      itemCount: pokemons.length,
      itemBuilder: (context, index) {
        final pokemon = pokemons[index];
        return PokemonItemWidget(
          pokemon: pokemon,
          position: index + 1,
        );
      },
    );
  }
}