abstract class IPokemon {
  int get id;

  String get name;

  int get baseExperience;

  int get height;

  int get weight;

  String get locationAreaEncounters;

  bool get isDefault;

  List<IPokemonType> get types;

  IPicture get picture;

  String toJson();
}

abstract class IPokemonType {
  String get name;

  String get url;

  Map<String, dynamic> toJson();
}

abstract class IPicture {
  String? get backDefault;

  String? get backFemale;

  String? get backShiny;

  String? get backShinyFemale;

  String? get frontDefault;

  String? get frontFemale;

  String? get frontShiny;

  String? get frontShinyFemale;

  Map<String, dynamic> toJson();
}
