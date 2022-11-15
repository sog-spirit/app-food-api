import 'dart:convert';

import 'package:http/http.dart';

import '../constants.dart';
import 'package:http/http.dart' as http;

import '../models/cart.dart';
import '../models/product.dart';

class CartServices {
  //[GET] - get all carts
  Future<List<Cart>> getCarts(int id) async {
    var client = http.Client();
    var url = Uri.parse("${baseApi}api/user/${id}/cart");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      return cartFromJson(json);
    } else {
      return [];
    }
  }

  Future<bool> getMockData() {
    return Future.value(true);
  }

  //[GET] - check product is in cart ?
  Future<bool> checkProductInCart(int userId, int productId) async {
    Future<bool> statusProduct;
    var client = http.Client();
    var url = Uri.parse("${baseApi}api/user/${userId}/product/${productId}");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      if (response.body == '{}') {
        bool stringFuture = await Future.value(false);
        bool message = stringFuture;
        return (message);
      } else {
        bool stringFuture = await Future.value(true);
        bool message = stringFuture;
        return (message);
      }
    } else {
      print('check khong thanh cong');
      return false;
    }
  }

  //get total products in cart
  Future<int> getTotalProductsInCart(int id) async {
    return 0;
  }

  //[POST] - add product to cart
  Future<bool> addCarts(int userId, int productId, int quantity) async {
    var url = Uri.parse("${baseApi}api/user/${userId}/cart");
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"product": ${productId}, "quantity": ${quantity}}';
    Response response = await post(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print('check post: ' + statusCode.toString());
    print('check eror : ' + response.body);
    return true;
  }

  //[PUT] - update product to cart
  Future<bool> updateCarts(int userId, int cartId, int quantity) async {
    var url = Uri.parse("${baseApi}api/user/${userId}/cart/${cartId}");
    Map<String, String> headers = {"Content-type": "application/json"};
    String json = '{"quantity": "${quantity}"}';
    Response response = await put(url, headers: headers, body: json);
    int statusCode = response.statusCode;
    print('check put: ' + statusCode.toString());
    print('check eror : ' + response.body);
    return true;
  }

  //[DELETE] - remove product from cart
  Future<bool> deleteCarts(int userId, int productId) async {
    var url = Uri.parse("${baseApi}api/user/${userId}/cart/${productId}");
    Response response = await delete(url);
    print('status: ' + response.statusCode.toString());
    print('mess: ' + response.body);
    return true;
  }
}
