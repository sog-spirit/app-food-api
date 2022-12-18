import 'dart:convert';
import 'dart:ffi';

import 'package:http/http.dart';

import '../../constants.dart';
import 'package:http/http.dart' as http;

import '../../models/user.dart';
import '../api/api_client.dart';

class AuthServices {
  //[POST] login
  Future<String> login(String username, String password) async {
    Map<String, String> data = {'username': username, 'password': password};
    print('data login $data');
    Response response = await ApiClient().POST('api/user/login', data);
    if (response.statusCode == 200) {
      print('dang nhap thanh cong');
      return response.body;
    }
    return '';
  }

  //[POST] register
  Future<bool> register(String username, String password, String phone,
      String email, String address, String dateOfBirth, String image) async {
    Map<String, String> data = {
      'username': username,
      'password': password,
      'email': email,
      'image':
          'https://scontent-hkt1-2.xx.fbcdn.net/v/t39.30808-6/318559222_3418524198416379_8228542129927971455_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=730e14&_nc_ohc=Y2CIWBRUUDYAX-hm2s0&tn=dnua9bGbAzzhQBgf&_nc_ht=scontent-hkt1-2.xx&oh=00_AfD7M0Mws3dABKrxvjV_nZhyVNGZ2Cz_x-qPkdgJ7FAkrw&oe=63991621',
      'phone': phone,
      'date_of_birth': '2001-12-12',
      'address': address,
      'name': 'Truong my 2ten'
    };
    print('data register $data');
    // tạo POST request
    Response response = await ApiClient().POST("api/user/register", data);
    // kiểm tra status code của kết quả response
    int statusCode = response.statusCode;
    if (statusCode == 201) {
      print('ket qua trong auth_services ${response.body}');
      return true;
    }
    return false;
  }

  //[POST] logout

  Future<bool> logout() async {
    Response response = await ApiClient().POST('api/user/logout', '');
    if (response.statusCode == 200) {
      // User user = User.fromJson(jsonDecode(response.body));
      // return user;
      print('log out thanh cong');
      return true;
    }
    return false;
  }
}
