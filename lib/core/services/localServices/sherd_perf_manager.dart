import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final SharedPreferences _prefs;

  SharedPreferencesService(this._prefs);

  Future<void> saveString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  String? getString(String key) {
    return _prefs.getString(key);
  }

  Future<void> removeString(String key) async {
    await _prefs.remove(key);
  }

  Future<void> saveBool(String key, bool value) async {
    await _prefs.setBool(key, value);
  }

  bool? getBool(String key) {
    return _prefs.getBool(key);
  }

  Future<void> removeBool(String key) async {
    await _prefs.remove(key);
  }

  cancelSharedPref() async {
    await _prefs.clear();
  }
}

final sharedPreferencesProvider =
    FutureProvider<SharedPreferencesService>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return SharedPreferencesService(prefs);
});
