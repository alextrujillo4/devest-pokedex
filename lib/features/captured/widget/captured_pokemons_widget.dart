import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/extensions.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon/pokemon_package.dart';

class CapturedPokemonItemWidget extends StatelessWidget {
  const CapturedPokemonItemWidget({
    super.key,
    required this.pokemon,
    required this.position,
  });

  final IPokemon pokemon;
  final int position;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push("/detail/${pokemon.id}");
      },
      child: Card(
        margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    key: const Key("captured_naming"),
                    pokemon.name.capitalize(),
                    maxLines: 1,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    pokemon.id.formattedPokemonId,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Type(s): ${pokemon.types.map((e) => e.name).toString()}",
                    style: const TextStyle(
                      fontSize: 13.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            CachedNetworkImage(
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              imageUrl: pokemon.picture.frontDefault ?? '',
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ],
        ),
      ),
    );
  }
}
