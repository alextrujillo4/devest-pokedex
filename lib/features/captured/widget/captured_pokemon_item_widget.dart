import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/features/captured/bloc/captured_bloc.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import 'captured_pokemons_widget.dart';

class CapturedPokemonsWidget extends StatefulWidget {
  final List<IPokemon> pokemons;

  const CapturedPokemonsWidget({super.key, required this.pokemons});

  @override
  State<CapturedPokemonsWidget> createState() => _CapturedPokemonsWidgetState();
}

class _CapturedPokemonsWidgetState extends State<CapturedPokemonsWidget> {
  int? _value = 0;
  final _orderBy = ["ID", "A-Z", "Z-A", "Type"];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [_buildFilters(), _buildListView(widget.pokemons)],
    );
  }

  Widget _buildFilters() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text('Order By'),
          Wrap(
            spacing: 5.0,
            children: List<Widget>.generate(
              4,
              (int index) {
                return ChoiceChip(
                  label: Text(_orderBy[index]),
                  selected: _value == index,
                  onSelected: (bool selected) {
                    setState(() {
                      _value = index;
                      context.read<CapturedBloc>().add(
                            Invoke(
                              params: GetFavoritesParams(
                                type: _value == 0
                                    ? FilterType.id
                                    : _value == 1
                                        ? FilterType.name
                                        : _value == 2
                                            ? FilterType.nameReversed
                                            : FilterType.type,
                              ),
                            ),
                          );
                    });
                  },
                );
              },
            ).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildListView(List<IPokemon> pokemons) {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: ListView.builder(
        itemCount: pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = pokemons[index];
          return CapturedPokemonItemWidget(
            key: Key("captured_pokemon_item_$index"),
            pokemon: pokemon,
            position: index + 1,
          );
        },
      ),
    );
  }
}
