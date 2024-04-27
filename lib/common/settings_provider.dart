import 'package:flutter/material.dart';
import 'package:flutter_pokedex/common/constants/app_colors.dart';
import 'package:pokemon/pokemon_package.dart';

class SettingsProvider extends ChangeNotifier {

  Color _predominantColor = AppColors.bostonUniversityRed;

  Color get predominantColor =>
      _predominantColor; // Use 'predominantColor' for consistency

  Future<void> evaluatePokedexColor(List<IPokemon> pokemons) async {
    final typeCounts = _countPokemonTypes(pokemons);
    final dominantType = _findDominantType(typeCounts);
    _predominantColor = AppColors.getPokemonColorType[dominantType] ??
        AppColors.bostonUniversityRed;
    print("UPDATED**: $dominantType");
    notifyListeners();
  }

  Map<String, int> _countPokemonTypes(List<IPokemon> pokemons) {
    final typeCount = <String, int>{};
    for (final pokemon in pokemons) {
      for (final type in pokemon.types) {
        typeCount.update(type.name, (value) => value + 1, ifAbsent: () => 1);
      }
    }
    return typeCount;
  }

  String? _findDominantType(Map<String, int> typeCounts) {
    if (typeCounts.isEmpty) {
      return null;
    }
    int maxValue = typeCounts.entries.first.value;
    String dominantType = typeCounts.entries.first.key;

    for (final entry in typeCounts.entries) {
      if (entry.value > maxValue) {
        maxValue = entry.value;
        dominantType = entry.key;
      }
    }
    var repeated = 0;
    for (final entry in typeCounts.entries) {
      if (entry.value == maxValue) {
        repeated++;
      }
    }
    return (repeated > 1) ? null : dominantType;
  }
}
