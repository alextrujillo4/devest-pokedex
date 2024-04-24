import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokedex/pokedex_package.dart';

abstract class PokedexRepository {
  Future<Either<Failure, IPokedex>> getPokedexByRegion(String region);
}
