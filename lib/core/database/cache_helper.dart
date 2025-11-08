import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> storeString(String key, String value) async {
    await sharedPreferences!.setString(key, value);
  }

  static String? getString(String key) {
    return sharedPreferences!.getString(key);
  }

  static Future<void> deleteString(String key) async {
    await sharedPreferences!.remove(key);
  }
}
