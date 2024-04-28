import 'package:pokedex/src/domain/entity/pokedex.dart';

Pokedex mockPokedex() {
  return Pokedex(
    id: 123,
    isMainSeries: true,
    name: "Pokemon",
    descriptions: [
      Description(
          description: "Description",
          language: Language(name: "en-EN", url: "someUrl"))
    ],
    names: [
      Name(language: Language(name: "en-EN", url: "someUrl"), name: "Pokemon")
    ],
    pokemonEntries: [
      PokemonEntry(
        entryNumber: 1,
        pokemonSpecies: PokemonSpecies(name: "Bulbasur", url: "someUrl"),
      ),
      PokemonEntry(
        entryNumber: 1,
        pokemonSpecies: PokemonSpecies(name: "Charmander", url: "someUrl"),
      ),
      PokemonEntry(
        entryNumber: 1,
        pokemonSpecies: PokemonSpecies(name: "Charmaleon", url: "someUrl"),
      )
    ],
    region: Region(name: "Region", url: "someUrl"),
    versionGroups: [VersionGroup(name: "VersionGroup", url: "someUrl")],
  );
}
