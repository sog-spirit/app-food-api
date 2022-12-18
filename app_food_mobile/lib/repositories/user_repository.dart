import 'dart:convert';

import 'package:app_food_mobile/models/order_item.dart';
import 'package:app_food_mobile/services/user_services.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/order.dart';
import '../models/productOrder.dart';
import '../models/user.dart';

class UserRepo {
  late SharedPreferences prefs;
  //get user
  Future<User?> getUser() async {
// lay id tu local
    prefs = await SharedPreferences.getInstance();
    final int? userId = prefs.getInt('user_id');
    print('lay userid tu local: $userId');
    if (userId != null) {
      User? user = await UserServices().getUser(userId);

      print('lay thanh cong tai repo: $user ');
      return user;
    }
    return null;
  }

  //thay doi thong tin nguoi dung tu services
  Future<bool> updateUser(String newValue, String label) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('get token trong repos: $token');
    if (token != null) {
      return await UserServices().updateInformation(newValue, token, label);
    }
    return false;
  }

  //thay doi password
  Future<bool> updatePassword(String currentPW, String newPW) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('get token trong repos: $token');
    if (token != null) {
      return await UserServices().updatePassword(currentPW, newPW, token);
    }
    return false;
  }

  //order down hang
  Future<bool> orderProducts(
      List<ProductOrder> products, User user, String address) async {
    prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    print('token $token');
    // ignore: unrelated_type_equality_checks
    if (token != '' && user != Null) {
      print('okk');
      return await UserServices().orderProduct(products, token!, user, address);
    }
    return true;
  }

  //get orders
  Future<List<Order>> getOrders() async {
    prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    if (userId == null) {
      print('khong tim thay');
      return [];
    } else {
      print('usrrId : $userId');
      return await UserServices().getOrders(userId);
    }
  }

  //get detail order
  Future<List<OrderItem>> getDetailOrder(int orderId) async {
    prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('user_id');
    // ignore: unnecessary_null_comparison
    if (userId == null) {
      print('khong tim thay');
      return [];
    } else {
      print('usrrId : $userId');
      return await UserServices().getOrderDetail(userId, orderId);
    }
  }
}
