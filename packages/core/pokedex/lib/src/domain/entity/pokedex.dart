abstract class IPokedex {
  List<IDescription> get descriptions;
  int get id;
  bool get isMainSeries;
  String get name;
  List<IName> get names;
  List<IPokemonEntry> get pokemonEntries;
  IRegion get region;
  List<IVersionGroup> get versionGroups;
}

class Pokedex implements IPokedex {
  @override
  final List<Description> descriptions;
  @override
  final int id;
  @override
  final bool isMainSeries;
  @override
  final String name;
  @override
  final List<Name> names;
  @override
  final List<PokemonEntry> pokemonEntries;
  @override
  final Region region;
  @override
  final List<VersionGroup> versionGroups;

  Pokedex({
    required this.descriptions,
    required this.id,
    required this.isMainSeries,
    required this.name,
    required this.names,
    required this.pokemonEntries,
    required this.region,
    required this.versionGroups,
  });
}

abstract class IDescription {
  String get description;
  ILanguage get language;
}

class Description implements IDescription {
  @override
  final String description;
  @override
  final Language language;

  Description({required this.description, required this.language});
}

abstract class ILanguage {
  String get name;
  String get url;
}

class Language implements ILanguage {
  @override
  final String name;
  @override
  final String url;

  Language({required this.name, required this.url});
}

abstract class IName {
  ILanguage get language;
  String get name;
}

class Name implements IName {
  @override
  final Language language;
  @override
  final String name;

  Name({required this.language, required this.name});
}

abstract class IPokemonEntry {
  int get entryNumber;
  IPokemonSpecies get pokemonSpecies;
}

class PokemonEntry implements IPokemonEntry {
  @override
  final int entryNumber;
  @override
  final PokemonSpecies pokemonSpecies;

  PokemonEntry({required this.entryNumber, required this.pokemonSpecies});
}

abstract class IPokemonSpecies {
  String get name;
  String get url;
}

class PokemonSpecies implements IPokemonSpecies {
  @override
  final String name;
  @override
  final String url;

  PokemonSpecies({required this.name, required this.url});
}

abstract class IRegion {
  String get name;
  String get url;
}

class Region implements IRegion {
  @override
  final String name;
  @override
  final String url;

  Region({required this.name, required this.url});
}

abstract class IVersionGroup {
  String get name;
  String get url;
}

class VersionGroup implements IVersionGroup {
  @override
  final String name;
  @override
  final String url;

  VersionGroup({required this.name, required this.url});
}
