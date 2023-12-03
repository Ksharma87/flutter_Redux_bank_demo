import 'package:flutter_redux_bank/preferences/preferences_contents.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
@singleton
class PreferencesManager {

  static SharedPreferences? prefs;

  static initManager() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<bool?> setPreferencesValue(String key, String value) async {
    return await prefs?.setString(key, value);
  }

  String? getPreferencesValue(String key) {
    return prefs?.getString(key);
  }

  String? getUid() {
    return prefs?.getString(PreferencesContents.userUid);
  }
}
