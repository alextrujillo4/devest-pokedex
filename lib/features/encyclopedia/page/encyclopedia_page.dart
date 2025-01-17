import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/common/widgets/loading_widget.dart';
import 'package:flutter_pokedex/common/widgets/problem_widget.dart';
import 'package:flutter_pokedex/features/encyclopedia/bloc/encyclopedia_bloc.dart';
import 'package:flutter_pokedex/features/encyclopedia/widget/animated_floating_action_button.dart';
import 'package:flutter_pokedex/features/encyclopedia/widget/search_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:state_manager/state_manager.dart';

import '../widget/pokemon_entry_widget.dart';

class EncyclopediaPage extends StatelessWidget {
  const EncyclopediaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).size.height < MediaQuery.of(context).size.width;
    return Scaffold(
      key: const Key("encyclopedia_page"),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Pokédex',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
      floatingActionButton: AnimatedFloatingActionButton(
        key: const Key("pokeball_btn"),
        onPressed: () => context.go("/captured"),
        imageAsset: "assets/images/pokeball.png",
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
                context.read<EncyclopediaBloc>().add(
                      Invoke(
                        params: PokedexParams(region: "kanto"),
                      ),
                    );
              },
            );
          } else if (state is SUCCESS<List<IPokemonEntry>>) {
            return Stack(
              children: [
                isLandscape
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Flexible(flex: 1, child: SizedBox()),
                          Flexible(
                            flex: 3,
                            child: _buildGridView(context, state.data),
                          ),
                          const Flexible(flex: 1, child: SizedBox()),
                        ],
                      )
                    : _buildGridView(context, state.data),
                const SearchBarWidget(
                  key: Key("search_widget"),
                ),
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
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 0.90,
        ),
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return PokemonItemWidget(
            key: Key("encyclopedia_pokemon_item_$index"),
            pokemon: pokemon,
            position: index + 1,
          );
        },
      ),
    );
  }
}
