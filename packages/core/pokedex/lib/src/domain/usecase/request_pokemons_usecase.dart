import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/domain/repository/pokedex_repository.dart';
import 'package:state_manager/state_manager.dart';

class RequestPokemonsUsecase
    implements UseCase<List<IPokemonEntry>, RequestAllParam> {
  final PokedexRepository repository;

  const RequestPokemonsUsecase(this.repository);

  @override
  Future<Either<Failure, List<IPokemonEntry>>> call(
    RequestAllParam params,
  ) async {
    final pokedex = await repository.getPokedexByRegion(params.region);
    return pokedex.fold((error) => Left(error), (success) {
      final query = (params.query ?? "").trim();
      return query.isNotEmpty
          ? Right(success.pokemonEntries.where((IPokemonEntry element) {
              return element.pokemonSpecies.name
                  .toLowerCase()
                  .contains(query.toLowerCase());
            }).toList())
          : Right(success.pokemonEntries);
    });
  }
}
