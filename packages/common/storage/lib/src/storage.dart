import 'package:shared_preferences/shared_preferences.dart';

class Storage {
  final SharedPreferences prefs;

  const Storage({required this.prefs});

  Future<bool> setString(String key, String value) async {
    return await prefs.setString(key, value);
  }

  String? getString(String key) {
    return prefs.getString(key);
  }

  Future<void> removeString(String key) async {
    await prefs.remove(key);
  }

  Future<bool> setStringList(String key, List<String> value) async =>
      await prefs.setStringList(key, value);

  List<String> getStringList(String key) => prefs.getStringList(key) ?? [];

  Future<void> removeStringList(String key) async => await prefs.remove(key);
}
