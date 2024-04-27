import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/app_assets.dart';
import 'package:flutter_svg/svg.dart';

class PokemonTypeIcon extends StatelessWidget {
  final String typeName;

  const PokemonTypeIcon({
    super.key,
    required this.typeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      padding: const EdgeInsets.only(left: 12),
      child: SvgPicture.asset(
        AppAssets.getTypeImagePath(typeName),
      ),
    );
  }
}
