import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/domain/entity/ipokemon.dart';

import '../entity/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, IPokemon>> getPokemonDetail(int id);

  Future<Either<Failure, List<IPokemon>>> getAllFavorites();

  Future<Either<Failure, IPokemon>> getFavoritePokemon(int id);

  Future<Either<Failure, bool>> deleteFromFavorite(int id);

  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon);

  Future<Either<Failure, bool>> getFavoriteStatus(int id);
}
