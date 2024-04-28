import 'package:get_it/get_it.dart';
import 'package:network/network.dart';
import 'package:pokedex/pokedex_package.dart';
import 'package:pokedex/src/data/repository/pokedex_repository_impl.dart';
import 'src/data/datasource/remote_data_source.dart';
import 'src/domain/repository/pokedex_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<PokedexRemoteDataSource>(
          () => PokedexRemoteDataSourceImpl(http: sl<HttpInterceptor>()));

  sl.registerFactory<RequestPokedexUsecase>(
          () => RequestPokedexUsecase(sl()));


  sl.registerFactory<PokedexRepository>(
    () => PokedexRepositoryImpl(remoteDataSource: sl()),
  );
}
