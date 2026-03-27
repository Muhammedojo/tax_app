import 'package:shared_preferences/shared_preferences.dart';
import 'istorage.dart';

class SharedPrefsStorage implements LocalStorage {
  final SharedPreferences _prefs;

  SharedPrefsStorage(this._prefs);

  static const _themeKey = 'theme_setting';
  static const _offlinePackKey = 'offline_pack_json';

  @override
  Future<void> setThemeSetting(String theme) async {
    await _prefs.setString(_themeKey, theme);
  }

  @override
  Future<String?> getThemeSetting() async {
    return _prefs.getString(_themeKey);
  }

  @override
  Future<void> saveOfflinePack(String json) async {
    await _prefs.setString(_offlinePackKey, json);
  }

  @override
  Future<String?> getOfflinePack() async {
    return _prefs.getString(_offlinePackKey);
  }

  @override
  Future<bool> hasOfflinePack() async {
    return _prefs.containsKey(_offlinePackKey);
  }
}
