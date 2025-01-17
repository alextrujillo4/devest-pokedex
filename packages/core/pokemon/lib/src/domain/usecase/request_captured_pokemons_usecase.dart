import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:state_manager/state_manager.dart';

class RequestCapturedPokemonsUsecase
    implements UseCase<List<IPokemon>, GetFavoritesParams> {
  final PokemonRepository repository;

  const RequestCapturedPokemonsUsecase(this.repository);

  @override
  Future<Either<Failure, List<IPokemon>>> call(
    GetFavoritesParams params,
  ) async {
    final pokedex = await repository.getAllFavorites();
    return pokedex.fold((error) => Left(error), (success) {
      if (params.type == FilterType.id) {
        success.sort((a, b) => a.id.compareTo(b.id));
      } else if (params.type == FilterType.name) {
        success.sort((a, b) => a.name.compareTo(b.name));
      }else if (params.type == FilterType.type) {
        success.sort((a, b) => a.types.first.name.compareTo(b.types.first.name));
      } else {
        success.sort((a, b) => b.name.compareTo(a.name));
      }
      return Right(success);
    });
  }
}
