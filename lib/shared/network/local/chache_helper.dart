import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolean({
    required String key,
    required bool value,
  }) async {
    return await sharedPreferences!.setBool(key, value);
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

    return await sharedPreferences!.setDouble(key, value);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }

  // static Future<bool> setThemeData({
  //   required String key,
  //   required String valueType,
  //   required Object value,
  // }) async {
  //   return await sharedPreferences!._setValue(key,valueType,value);
  // }
  static Future<bool> setStringList({
    required String key,
    required List<String>? value,
  }) async {
    return await sharedPreferences!.setStringList(key, value!);
  }
    static dynamic getStringList({
    required String key,
  }) {
    return sharedPreferences?.getStringList(key);
  }
}
