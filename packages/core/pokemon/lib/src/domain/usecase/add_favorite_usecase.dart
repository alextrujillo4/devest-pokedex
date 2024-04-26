import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

import '../entity/pokemon.dart';

class AddFavoriteUseCase implements UseCase<bool, Pokemon> {
  final PokemonRepository repository;

  const AddFavoriteUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(IPokemon pokemon) async {
    return await repository.addToFavorite(
      Pokemon(
        id: pokemon.id,
        name: pokemon.name,
        baseExperience: pokemon.baseExperience,
        height: pokemon.height,
        weight: pokemon.weight,
        locationAreaEncounters: pokemon.locationAreaEncounters,
        isDefault: pokemon.isDefault,
        types: pokemon.types
            .map((e) => PokemonType(name: e.name, url: e.url))
            .toList(),
        picture: Picture(
          backDefault: pokemon.picture.backDefault,
          backFemale: pokemon.picture.backFemale,
          backShiny: pokemon.picture.backShiny,
          backShinyFemale: pokemon.picture.backShinyFemale,
          frontDefault: pokemon.picture.frontDefault,
          frontFemale: pokemon.picture.frontFemale,
          frontShiny: pokemon.picture.frontShiny,
          frontShinyFemale: pokemon.picture.frontShinyFemale,
        ),
      ),
    );
  }
}
