import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  late SharedPreferences _prefs;

  // Private constructor to prevent external instantiation
  SharedPreferencesManager._();

  // Singleton instance
  static final SharedPreferencesManager instance =
      SharedPreferencesManager._();

  // Initialize SharedPreferences when first accessed
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Your SharedPreferences getter and setter methods
  String getString(String key, String defaultValue) {
    return _prefs.getString(key) ?? defaultValue;
  }

  Future<void> setString(String key, String value) async {
    await _prefs.setString(key, value);
  }

  Future<void> clearStorage() async {
    await _prefs.clear();
  }


 bool getBool(String key, bool defaultValue) {
    return _prefs.getBool(key) ?? defaultValue;
  }
  Future<void> setBool(String key,bool value) async {
    await _prefs.setBool(key,value);
  }
}
