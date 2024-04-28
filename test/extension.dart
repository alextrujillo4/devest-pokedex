
import 'package:pokedex/pokedex_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/domain/entity/pokemon.dart';

IPokemon mockPokemon() {
  return  Pokemon(
    id: 151,
    name: "some-name",
    baseExperience: 50,
    height: 123,
    weight: 123,
    locationAreaEncounters: "locationAreaEncounters",
    isDefault: true,
    types: [PokemonType(name: "name", url: "url")],
    picture: Picture(),
  );
}


IPokemonEntry mockPokemonEntry() {
  return PokemonEntry(
    entryNumber: 1,
    pokemonSpecies: PokemonSpecies(name: "Charmander", url: "someUrl"),
  );
}


