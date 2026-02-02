import 'package:shared_preferences/shared_preferences.dart';

class Cachhelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) {
      return await prefs.setString(key, value);
    } else if (value is double) {
      return await prefs.setDouble(key, value);
    } else if (value is int) {
      return await prefs.setInt(key, value);
    } else if (value is bool) {
      return await prefs.setBool(key, value);
    } else if (value is List<String>) {
      return await prefs.setStringList(key, value);
    } else {
      return false;
    }
  }

  static getData({required String key}) {
    return prefs.get(key);
  }
}
