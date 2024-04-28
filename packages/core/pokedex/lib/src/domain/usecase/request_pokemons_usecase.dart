import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/domain/repository/pokedex_repository.dart';
import 'package:state_manager/state_manager.dart';

class RequestPokedexUsecase
    implements UseCase<List<IPokemonEntry>, PokedexParams> {
  final PokedexRepository repository;

  const RequestPokedexUsecase(this.repository);

  @override
  Future<Either<Failure, List<IPokemonEntry>>> call(
    PokedexParams params,
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
