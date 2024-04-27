import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/app_assets.dart';

class PokemonFootIcon extends StatelessWidget {
  final int id;

  const PokemonFootIcon({
    super.key,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52,
      width: 52,
      padding: const EdgeInsets.only(left: 12),
      child: Image.asset(
        color: Colors.white,
        fit: BoxFit.fill,
        AppAssets.getFootprintImagePath(id),
      ),

    );
  }
}
