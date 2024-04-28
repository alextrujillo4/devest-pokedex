import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:pokemon/pokemon_package.dart';
import 'package:pokemon/src/data/datasource/local_data_source.dart';
import 'package:pokemon/src/data/datasource/remote_data_source.dart';
import 'package:pokemon/src/data/repository/repository_impl.dart';
import 'package:storage/storage_package.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<PokemonRepository>(() => PokemonRepositoryImpl(
      remoteDataSource: sl<PokemonRemoteDatasource>(),
      localDatasource: sl<PokemonLocalDatasource>()));

  sl.registerFactory<PokemonRemoteDatasource>(
    () => PokemonRemoteDatasourceImpl(http: sl<HttpInterceptor>()),
  );

  sl.registerFactory<PokemonLocalDatasource>(
    () => PokemonLocalDatasourceImpl(storage: sl<Storage>()),
  );

  sl.registerFactory<AddFavoriteUseCase>(
    () => AddFavoriteUseCase(sl()),
  );

  sl.registerFactory<RequestCapturedPokemonsUsecase>(
    () => RequestCapturedPokemonsUsecase(sl()),
  );
}
