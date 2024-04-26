import 'package:pokemon/src/domain/entity/pokemon.dart';

class PokemonDto {
  final int id;
  final String name;
  final int baseExperience;
  final int height;
  final int weight;
  final String locationAreaEncounters;
  final bool isDefault;
  final List<PokemonTypeDto> types;
  final PictureDto picture;

  PokemonDto({
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


  factory PokemonDto.fromJson(Map<String, dynamic> json) {

    List<PokemonTypeDto> types = json['types'] != null
        ? (json['types'] as List<dynamic>)
        .map((types) =>
        PokemonTypeDto.fromJson((types['type'])))
        .toList()
        : [];

    PictureDto picture = PictureDto.fromJson(json['sprites']);

    return PokemonDto(
      id: json['id'],
      name: json['name'],
      baseExperience: json['base_experience'],
      height: json['height'],
      weight: json['weight'],
      locationAreaEncounters: json['location_area_encounters'],
      isDefault: json['is_default'],
      types: types,
      picture: picture,
    );
  }

  Pokemon toDomain() {
    return Pokemon(
      id: id,
      name: name,
      baseExperience: baseExperience,
      height: height,
      weight: weight,
      locationAreaEncounters: locationAreaEncounters,
      isDefault: isDefault,
      types: types.map((e) => e.toDomain()).toList(),
      picture: picture.toDomain(),
    );
  }
}

class PictureDto {
  final String? backDefault;
  final String? backFemale;
  final String? backShiny;
  final String? backShinyFemale;
  final String? frontDefault;
  final String? frontFemale;
  final String? frontShiny;
  final String? frontShinyFemale;

  PictureDto({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  Picture toDomain() => Picture(
        backDefault: backDefault,
        backFemale: backFemale,
        backShiny: backShiny,
        backShinyFemale: backShinyFemale,
        frontDefault: frontDefault,
        frontFemale: frontFemale,
        frontShiny: frontShiny,
        frontShinyFemale: frontShinyFemale,
      );

  factory PictureDto.fromJson(Map<String, dynamic> json) {
    return PictureDto(
      backDefault: json['back_default'],
      backFemale: json['back_female'],
      backShiny: json['back_shiny'],
      backShinyFemale: json['back_shiny_female'],
      frontDefault: json['front_default'],
      frontFemale: json['front_female'],
      frontShiny: json['front_shiny'],
      frontShinyFemale: json['front_shiny_female'],
    );
  }
}

class PokemonTypeDto {
  final String name;
  final String url;

  PokemonTypeDto({
    required this.name,
    required this.url,
  });

  factory PokemonTypeDto.fromJson(Map<String, dynamic> json) {
    return PokemonTypeDto(
      name: json['name'] as String,
      url: json['url'] as String,
    );
  }

  PokemonType toDomain() => PokemonType(name: name, url: url);
}
