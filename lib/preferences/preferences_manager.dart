import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class PreferencesManager {
  PreferencesManager._internal();

  static final PreferencesManager _instance = PreferencesManager._internal();
  static SharedPreferences? prefs;

  factory PreferencesManager() {
    return _instance;
  }

  static initManager() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> setPreferencesValue(String key, String value) async {
    return await prefs?.setString(key, value);
  }

  String? getPreferencesValue(String key) {
    return prefs?.getString(key);
  }
}
