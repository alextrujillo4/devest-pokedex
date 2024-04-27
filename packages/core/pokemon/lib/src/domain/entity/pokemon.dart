import 'dart:convert';

import 'package:pokemon/src/domain/entity/ipokemon.dart';

class Pokemon implements IPokemon {
  @override
  final int id;
  @override
  final String name;
  @override
  final int baseExperience;
  @override
  final int height;
  @override
  final int weight;
  @override
  final String locationAreaEncounters;
  @override
  final bool isDefault;
  @override
  final List<PokemonType> types;
  @override
  final Picture picture;

  @override
  String get description {
    return "The Pokémon $name is a ${types.map((e) => e.name )} type. It stands at $height decimetres tall and weighs $weight hectograms. And Base Experience of $baseExperience of 1000.";
  }

  Pokemon({
    required this.id,
    required this.name,
    required this.baseExperience,
    required this.height,
    required this.weight,
    required this.locationAreaEncounters,
    required this.isDefault,
    required this.types,
    required this.picture,
  });

  @override
  String toJson() {
    Map<String, dynamic> jsonMap = {
      'id': id,
      'name': name,
      'base_experience': baseExperience,
      'height': height,
      'weight': weight,
      'location_area_encounters': locationAreaEncounters,
      'is_default': isDefault,
      'types': types.map((type) => {'type': type.toJson()}).toList(),
      'sprites': picture.toJson(),
    };
    return jsonEncode(jsonMap);
  }
}

class PokemonType implements IPokemonType {
  @override
  final String name;
  @override
  final String url;

  PokemonType({
    required this.name,
    required this.url,
  });

  @override
  Map<String, String> toJson() {
    return {
      'name': name,
      'url': url,
    };
  }
}

class Picture implements IPicture {
  @override
  final String? backDefault;
  @override
  final String? backFemale;
  @override
  final String? backShiny;
  @override
  final String? backShinyFemale;
  @override
  final String? frontDefault;
  @override
  final String? frontFemale;
  @override
  final String? frontShiny;
  @override
  final String? frontShinyFemale;

  Picture({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });


  @override
  Map<String, String?> toJson() {
    return {
      'back_default': backDefault,
      'back_female': backFemale,
      'back_shiny': backShiny,
      'back_shiny_female': backShinyFemale,
      'front_default': frontDefault,
      'front_female': frontFemale,
      'front_shiny': frontShiny,
      'front_shiny_female': frontShinyFemale,
    };
  }
}
