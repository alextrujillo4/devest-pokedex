
import 'package:pokemon/src/domain/entity/pokemon.dart';

Pokemon mockPokemon() {
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
