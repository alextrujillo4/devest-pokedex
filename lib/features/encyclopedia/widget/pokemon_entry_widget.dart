import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/extensions.dart';
import 'package:flutter_pokedex/di.dart';
import 'package:flutter_pokedex/features/detail/bloc/pokemon_detail_bloc.dart';
import 'package:flutter_pokedex/features/detail/page/detail_page.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

class PokemonItemWidget extends StatelessWidget {
  const PokemonItemWidget({
    super.key,
    required this.pokemon,
    required this.position,
  });

  final IPokemonEntry pokemon;
  final int position;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DetailPage(
              bloc: sl<PokemonDetailBloc>()
                ..add(Invoke(params: RequestParam(id: pokemon.entryNumber))),
              selectedPokemonId: pokemon.entryNumber,
            ),
          ),
        );
      },
      child: Card(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    pokemon.pokemonSpecies.name.capitalize(),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "$position",
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              height: 120,
              width: double.infinity,
              "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${pokemon.entryNumber}.png",
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
