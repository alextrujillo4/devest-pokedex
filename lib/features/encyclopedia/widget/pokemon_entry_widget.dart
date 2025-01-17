import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:pokedex/pokedex_package.dart';

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
        context.go("/pokemon/${pokemon.entryNumber}");
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
                    key:const Key("entry_naming"),
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
                    pokemon.entryNumber.formattedPokemonId,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Image.network(
              height: 100,
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
