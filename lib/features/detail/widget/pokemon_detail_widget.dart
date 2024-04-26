import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_pokedex/common/constants/extensions.dart';
import 'package:pokemon/pokemon_package.dart';

class PokemonDetailWidget extends StatelessWidget {
  final IPokemon pokemon;

  const PokemonDetailWidget({
    super.key,
    required this.pokemon,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            pokemon.name.capitalize(),
            maxLines: 1,
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 40.0,
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: CachedNetworkImage(
              width: 180,
              height: 180,
              fit:BoxFit.cover,
              imageUrl: pokemon.picture.frontDefault ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Base Experience: ${pokemon.baseExperience}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 10),
          Text(
            'Height: ${pokemon.height} decimetres',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 10),
          Text(
            'Weight: ${pokemon.weight} hectograms',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 10),
          Text(
            'Location of Encounters: ${pokemon.locationAreaEncounters}',
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 20),
          Text(
            'Types:',
            style: Theme.of(context).textTheme.headline6,
          ),
          Column(
            children: pokemon.types
                .map((type) => Text(
              type.name,
              style: Theme.of(context).textTheme.bodyText1,
            ))
                .toList(),
          ),
          if (pokemon.isDefault)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'This is a default Pokémon.',
                style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.green),
              ),
            ),
        ],
      ),
    );
  }
}
