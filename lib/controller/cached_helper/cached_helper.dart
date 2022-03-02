import 'package:mohtaref_client/controller/cached_helper/key_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedHelper {
  static SharedPreferences? prefs;
  static init() async {
    prefs = await SharedPreferences.getInstance();
    // setData(key: languageKey, value: 'ar');
    getData(key: languageKey);
  }

  static Future<bool> setData({
    required String? key,
    required dynamic value,
  }) async {
    if (value is String) return await prefs!.setString(key!, value);
    if (value is bool) return await prefs!.setBool(key!, value);
    if (value is int) return await prefs!.setInt(key!, value);

    return await prefs!.setDouble(key!, value);
  }

  static dynamic getData({
    required String? key,
  }) {
    return prefs!.get(key!);
  }

  static Future removeData({
    required String? key,
  }) {
    return prefs!.remove(key!);
  }

  static Future<bool> setDouble({
    required String? key,
    required double value,
  }) async {
    return await prefs!.setDouble(key!, value);
  }

  static double? getDouble({
    required String? key,
  }) {
    return prefs!.getDouble(key!);
  }
}
