import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/data/datasource/local_data_source.dart';
import 'package:pokemon/src/data/datasource/remote_data_source.dart';

class PokemonRepositoryImpl extends ErrorHandler implements PokemonRepository {
  final PokemonRemoteDatasource _remoteDatasource;
  final PokemonLocalDatasource _localDatasource;

  PokemonRepositoryImpl(
      {required PokemonRemoteDatasource remoteDataSource,
      required PokemonLocalDatasource localDatasource})
      : _remoteDatasource = remoteDataSource,
        _localDatasource = localDatasource;

  @override
  Future<Either<Failure, IPokemon>> getPokemonDetail(int id) async =>
      handle<IPokemon>(
          () async => await _remoteDatasource.requestPokemonDetail(id));

  @override
  Future<Either<Failure, bool>> addToFavorite(IPokemon pokemon) async =>
      handle<bool>(() async => await _localDatasource.addToFavorites(pokemon));

  @override
  Future<Either<Failure, bool>> deleteFromFavorite(int id) async =>
      handle<bool>(() async => await _localDatasource.deleteFromFavorites(id));

  @override
  Future<Either<Failure, List<IPokemon>>> getAllFavorites() async =>
      handle<List<IPokemon>>(() async => await _localDatasource.getFavorites());

  @override
  Future<Either<Failure, IPokemon>> getFavoritePokemon(int id) async =>
      handle<IPokemon>(() async => await _localDatasource.getFavoriteById(id));

  @override
  Future<Either<Failure, bool>> getFavoriteStatus(int id) async =>
      handle<bool>(() async => await _localDatasource.isFavorite(id));
}
