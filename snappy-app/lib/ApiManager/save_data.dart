import 'dart:convert';

import 'package:photos_by_snappy/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SaveData {
  static SharedPreferences? preferences;

  static Future<void> setUserData({required UserModel? userModel}) async {
    preferences = await SharedPreferences.getInstance();
    preferences!.setString('userModel', jsonEncode(userModel));
  }

  static Future<UserModel> getUserData() async {
    preferences = await SharedPreferences.getInstance();
    var temp = preferences!.getString("userModel");
    return UserModel.fromJson(jsonDecode(temp.toString()));
  }

  static removeSharedPrefData() async {
    preferences = await SharedPreferences.getInstance();

    preferences!.remove("userModel");
  }
}
