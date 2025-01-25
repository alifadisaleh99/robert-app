import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();

    if (CacheHelper.getData(key: 'locale') == null) {
      CacheHelper.saveData(key: 'locale', value: 'ar');
    }
  }

  static Future<bool> putBoolean({
    required String key,
    bool value = false,
  }) async {
    return await sharedPreferences?.setBool(key, value) ?? false;
  }

  static bool? getBoolean({
    required String key,
  }) {
    return sharedPreferences!.getBool(key);
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences?.get(key);
  }

  static Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences!.setString(key, value);
    if (value is int) return await sharedPreferences!.setInt(key, value);
    if (value is bool) return await sharedPreferences!.setBool(key, value);
    if (value is double) return await sharedPreferences!.setDouble(key, value);

    return true;
  }

  static Future<void> removeUser(String key) async {
    await sharedPreferences!.remove(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  static Future<bool> saveFilterBody({
    required String key,
    required String value,
  }) async {
    return await sharedPreferences!.setString(key, value);
  }

  static Future<bool> getFilterBody({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }


  Future<bool> saveLocalizationCode(String locale) =>
      sharedPreferences!.setString('localization', locale);

  static Future<bool> saveIntList({
    required String key,
    required List<int>? intList,
  }) async {
    if (intList == null) {
      return false;
    }
    final jsonString = json.encode(intList);
    return await sharedPreferences!.setString(key, jsonString);
  }

  static List<int> getIntList(String key) {
    final jsonString = sharedPreferences!.getString(key);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final List intList = json.decode(jsonString);
        if (intList.isNotEmpty) {
          return intList.cast<int>();
        } else {
          return [];
        }
      } catch (e) {
        print("Error decoding JSON: $e");
      }
    }
    return [];
  }

  static Future<void> clearAllData() async {
    await sharedPreferences!.clear();
  }

  static Future<void> clearAllDataExcept(List<String> keysToKeep) async {
    final keys = sharedPreferences!.getKeys().toList();

    for (final key in keys) {
      if (!keysToKeep.contains(key)) {
        await sharedPreferences!.remove(key);
      }
    }
  }


}
