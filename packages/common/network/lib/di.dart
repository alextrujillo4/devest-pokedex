import 'package:get_it/get_it.dart';
import 'package:network/src/network_contants.dart';

import 'network.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory<HttpClient>(() => HttpClient(
        domain: NetworkConstants.url,
      ));

  sl.registerFactory<HttpInterceptor>(
    () => HttpInterceptor(client: sl<HttpClient>()),
  );
}
