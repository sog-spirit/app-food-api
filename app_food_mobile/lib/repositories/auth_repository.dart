import 'dart:convert';

import 'package:app_food_mobile/services/auth/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  late final prefs;
  static bool isLogin = false;
  Future<bool> loginRepo(String username, String password) async {
    var result = await AuthServices().login(username, password);
    if (result != "") {
      prefs = await SharedPreferences.getInstance();
      String token = jsonDecode(result)['jwt'];
      int userId = jsonDecode(result)['user_id'];
      await prefs.setString('token', token);
      await prefs.setInt('user_id', userId);
      return true;
    }
    return false;
  }

  Future<bool> registerRepo(String username, String password, String phone,
      String email, String address, String dateOfBirth, String image) async {
    var result = await AuthServices().register(
        username, password, phone, email, address, dateOfBirth, image);
    print('auth repo');
    if (result) {
      print('ket qua trong resigster repo $result');
      return true;
    }
    return false;
  }

  Future<bool> checkLogined() async {
    prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');
    if (userId != null) {
      return Future<bool>.value(true);
    }
    return Future<bool>.value(false);
  }

  //log out
  Future<bool> logout() async {
    var result = await AuthServices().logout();
    if (result) {
      prefs = await SharedPreferences.getInstance();
      var success = await prefs.remove('user_id');
      print('xoa user_id $success');
      var success2 = await prefs.remove('token');
      print('xoa token $success2');
    }
    return result;
  }
}
