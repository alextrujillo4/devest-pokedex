import 'package:pokedex/pokedex_package.dart';

class PokedexDto {
  final List<DescriptionDto> descriptions;
  final int id;
  final bool isMainSeries;
  final String name;
  final List<NameDto> names;
  final List<PokemonEntryDto> pokemonEntries;
  final RegionDto region;
  final List<VersionGroupDto> versionGroups;

  PokedexDto({
    required this.descriptions,
    required this.id,
    required this.isMainSeries,
    required this.name,
    required this.names,
    required this.pokemonEntries,
    required this.region,
    required this.versionGroups,
  });

  Pokedex toDomain() {
    return Pokedex(
      descriptions: descriptions.map((d) => d.toDomain()).toList(),
      id: id,
      isMainSeries: isMainSeries,
      name: name,
      names: names.map((n) => n.toDomain()).toList(),
      pokemonEntries: pokemonEntries.map((p) => p.toDomain()).toList(),
      region: region.toDomain(),
      versionGroups: versionGroups.map((v) => v.toDomain()).toList(),
    );
  }

  factory PokedexDto.fromJson(Map<String, dynamic> json) {
    return PokedexDto(
      descriptions: List<DescriptionDto>.from(json['descriptions'].map((x) => DescriptionDto.fromJson(x))),
      id: json['id'],
      isMainSeries: json['is_main_series'],
      name: json['name'],
      names: List<NameDto>.from(json['names'].map((x) => NameDto.fromJson(x))),
      pokemonEntries: List<PokemonEntryDto>.from(json['pokemon_entries'].map((x) => PokemonEntryDto.fromJson(x))),
      region: RegionDto.fromJson(json['region']),
      versionGroups: List<VersionGroupDto>.from(json['version_groups'].map((x) => VersionGroupDto.fromJson(x))),
    );
  }
}

class DescriptionDto {
  final String description;
  final LanguageDto language;

  DescriptionDto({required this.description, required this.language});

  Description toDomain() {
    return Description(
      description: description,
      language: language.toDomain(),
    );
  }

  factory DescriptionDto.fromJson(Map<String, dynamic> json) {
    return DescriptionDto(
      description: json['description'],
      language: LanguageDto.fromJson(json['language']),
    );
  }
}

class LanguageDto {
  final String name;
  final String url;

  LanguageDto({required this.name, required this.url});

  Language toDomain() {
    return Language(
      name: name,
      url: url,
    );
  }

  factory LanguageDto.fromJson(Map<String, dynamic> json) {
    return LanguageDto(
      name: json['name'],
      url: json['url'],
    );
  }
}

class NameDto {
  final LanguageDto language;
  final String name;

  NameDto({required this.language, required this.name});

  Name toDomain() {
    return Name(
      language: language.toDomain(),
      name: name,
    );
  }

  factory NameDto.fromJson(Map<String, dynamic> json) {
    return NameDto(
      language: LanguageDto.fromJson(json['language']),
      name: json['name'],
    );
  }
}

class PokemonEntryDto {
  final int entryNumber;
  final PokemonSpeciesDto pokemonSpecies;

  PokemonEntryDto({required this.entryNumber, required this.pokemonSpecies});

  PokemonEntry toDomain() {
    return PokemonEntry(
      entryNumber: entryNumber,
      pokemonSpecies: pokemonSpecies.toDomain(),
    );
  }

  factory PokemonEntryDto.fromJson(Map<String, dynamic> json) {
    return PokemonEntryDto(
      entryNumber: json['entry_number'],
      pokemonSpecies: PokemonSpeciesDto.fromJson(json['pokemon_species']),
    );
  }
}

class PokemonSpeciesDto {
  final String name;
  final String url;

  PokemonSpeciesDto({required this.name, required this.url});

  PokemonSpecies toDomain() {
    return PokemonSpecies(
      name: name,
      url: url,
    );
  }

  factory PokemonSpeciesDto.fromJson(Map<String, dynamic> json) {
    return PokemonSpeciesDto(
      name: json['name'],
      url: json['url'],
    );
  }
}

class RegionDto {
  final String name;
  final String url;

  RegionDto({required this.name, required this.url});

  Region toDomain() {
    return Region(
      name: name,
      url: url,
    );
  }

  factory RegionDto.fromJson(Map<String, dynamic> json) {
    return RegionDto(
      name: json['name'],
      url: json['url'],
    );
  }
}

class VersionGroupDto {
  final String name;
  final String url;

  VersionGroupDto({required this.name, required this.url});

  VersionGroup toDomain() {
    return VersionGroup(
      name: name,
      url: url,
    );
  }

  factory VersionGroupDto.fromJson(Map<String, dynamic> json) {
    return VersionGroupDto(
      name: json['name'],
      url: json['url'],
    );
  }
}
