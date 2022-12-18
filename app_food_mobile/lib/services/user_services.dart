import 'dart:convert';

import 'package:app_food_mobile/models/order.dart';
import 'package:app_food_mobile/models/order_item.dart';
import 'package:app_food_mobile/models/product.dart';
import 'package:app_food_mobile/models/productOrder.dart';
import 'package:app_food_mobile/services/api/api_client.dart';
import 'package:http/http.dart';
import 'package:http/retry.dart';

import '../constants.dart';
import '../models/user.dart';
import 'package:http/http.dart' as http;

class UserServices {
  //GET
  Future<User?> getUser(int userId) async {
    Response response = await ApiClient().GET('api/user/$userId');
    print('@@@@: ${response.statusCode}');
    // print('body: ${jsonDecode(response.body)}');
    // print('utf8 for code: ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
      User user = User.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
      print('get thanh cong tai services: ${user.toString()}');
      return user;
    }
    return null;
  }

  //PATCH - updateinformation
  Future<bool> updateInformation(
      String newValue, String token, String label) async {
    Map<String, String> data = {label: newValue, 'token': token};
    Response response = await ApiClient().PATCH('api/user/update', data);
    if (response.statusCode == 200) {
      print('update password thanh cong: ');
      return true;
    }
    return false;
  }

  //PATCH - update password
  Future<bool> updatePassword(
      String currentPW, String newPW, String token) async {
    Map<String, String> data = {
      'current_password': currentPW,
      'new_password': newPW,
      'token': token
    };
    Response response =
        await ApiClient().PATCH('api/user/update/password', data);
    if (response.statusCode == 200) {
      print('uipdate services thanh cong: ');
      return true;
    }
    return false;
  }

  //GET - get orders
  Future<List<Order>> getOrders(int userId) async {
    Response response = await ApiClient().GET('api/user/$userId/order');
    print('@@@@: ${response.statusCode}');
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      return orderFromJson(json);
    } else {
      return [];
    }
  }

  //POST - order products
  Future<bool> orderProduct(List<ProductOrder> products, String token,
      User user, String address) async {
    Map<String, Object> data = {
      // "products": jsonEncode(products.map((e) => e.toJson()).toList()),
      "products": products,
      "address": address,
      "note": "Kiểm tra tạo đánh giá giỏ hàng bởi người dùng khác",
      "token": token
    };
    Response response = await ApiClient().POST("api/order", data);
    print('ket qua: ${response.statusCode}');
    print('ket qua: ${utf8.decode(response.bodyBytes)}');
    if (response.statusCode == 200) {
      print('dat hang thanh cong');
      return true;
    }
    return false;
  }

  //GET - order detail
  Future<List<OrderItem>> getOrderDetail(int userId, int orderId) async {
    Response response =
        await ApiClient().GET('api/user/$userId/order/$orderId');
    print('@@@@: ${response.statusCode}');
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      // return orderFromJson(json);
      return orderItemFromJson(json);
    } else {
      return [];
    }
  }
}
