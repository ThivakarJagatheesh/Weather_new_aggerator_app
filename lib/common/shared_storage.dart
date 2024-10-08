import 'package:shared_preferences/shared_preferences.dart';

class SharedStorage {
  static Future<SharedPreferences> get _instance async =>
      _prefsInstance ??= await SharedPreferences.getInstance();
  static SharedPreferences? _prefsInstance;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _prefsInstance = await _instance;
    return _prefsInstance!;
  }

  // Future getDirectory() async {
  //   Directory dir = await getApplicationDocumentsDirectory();
  //   String path = dir.path;
  // }
  static String getString(String key, [String? defValue]) {
    return _prefsInstance!.getString(key) ?? defValue ?? "";
  }

  static Future<bool> setString(String key, String value) async {
    var prefs = await _instance;
    return prefs.setString(key, value);
  }

  static int? getInt(String key, [int? defValue]) {
    return _prefsInstance!.getInt(key) ?? defValue ?? 0;
  }

  static Future<bool> setInt(String key, int value) async {
    var prefs = await _instance;
    return prefs.setInt(key, value);
  }

  static bool getBool(String key, [bool? defValue]) {
    return _prefsInstance!.getBool(key) ?? defValue ?? false;
  }

  static Future<bool> setBool(String key, bool value) async {
    var prefs = await _instance;
    return prefs.setBool(key, value);
  }

  static Future<bool> remove(String key, [bool? def]) async {
    var prefs = await _instance;
    return prefs.remove(key);
  }

  removeAll() async {
    var prefs = await _instance;
    return prefs.clear();
  }
}
