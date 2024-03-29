import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> PutBoolean(
      @required String key,
      @required dynamic value,
      )async
  {
    await sharedPreferences.setBool(key, value);
  }

  static bool GetBoolean(
      @required String key,
      )
  {
    return sharedPreferences.get(key);
  }

}