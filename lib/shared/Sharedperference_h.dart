import 'package:shared_preferences/shared_preferences.dart';

class Cachehelp {
  static SharedPreferences? shareddata;
  static init() async {
    shareddata = await SharedPreferences.getInstance();
  }

  static Future<bool> savebool({
    required String key,
    required bool value,
  }) async {
    return await shareddata!.setBool(key, value);
  }

  static Future<bool> savestring({
    required String key,
    required String value,
  }) async {
    return await shareddata!.setString(key, value);
  }

  static dynamic getdata({required String key}) {
    return shareddata!.get(key);
  }

  static void removedata({required key}) async {
    await shareddata!.remove(key);
  }
}
