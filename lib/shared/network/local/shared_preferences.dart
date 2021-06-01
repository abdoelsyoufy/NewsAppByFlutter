import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{

  static SharedPreferences sharedPreferences;

   static  getSharedInstance() async
   {
     sharedPreferences = await SharedPreferences.getInstance();
   }

 static  Future<bool> setData({
     @required String key,
     @required value
}) async
   {
     return await sharedPreferences.setBool(key, value);
   }

  static bool getData({
    @required String key,
  })
  {
    return sharedPreferences.getBool(key);
  }
}