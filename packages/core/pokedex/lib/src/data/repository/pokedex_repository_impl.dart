import 'package:dartz/dartz.dart';
import 'package:failure/failure_package.dart';
import 'package:pokedex/pokedex_package.dart';

import '../datasource/remote_data_source.dart';

class PokedexRepositoryImpl extends ErrorHandler
    implements PokedexRepository {
  final PokedexRemoteDataSource _remoteDatasource;

  PokedexRepositoryImpl(
      {required PokedexRemoteDataSource remoteDataSource})
      : _remoteDatasource = remoteDataSource;

  @override
  Future<Either<Failure, IPokedex>> getPokedexByRegion(String region) async =>
      handle<IPokedex>(() async => await _remoteDatasource
          .requestPokedexByRegion(region));

}
