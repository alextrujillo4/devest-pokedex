import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:storage/storage_package.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);
  sl.registerFactory<Storage>(() => Storage(prefs: sl<SharedPreferences>()));
}
