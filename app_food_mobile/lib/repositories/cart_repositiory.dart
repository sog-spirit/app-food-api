import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart.dart';
import '../models/product.dart';

class CartRepository {
  late SharedPreferences prefs;

  //[GET] - get all carts
  Future<List<Cart>> getCarts() async {
    prefs = await SharedPreferences.getInstance();
    List<String> listCart = await prefs.getStringList('my-list-cart') ?? [];
    List<Cart> carts = [];
    if (listCart != []) {
      for (var itemCart in listCart) {
        Cart cart = Cart.fromJson(jsonDecode(itemCart));
        carts.add(cart);
      }
      return carts;
    } else {
      return [];
    }
  }

  //[GET] - check product is in cart ?
  Future<bool> checkProductInCart(int productId) async {
    prefs = await SharedPreferences.getInstance();
    List<String> listCart = await prefs.getStringList('my-list-cart') ?? [];
    List<Cart> carts = [];
    if (listCart != []) {
      for (var itemCart in listCart) {
        Cart cart = Cart.fromJson(jsonDecode(itemCart));
        carts.add(cart);
      }
      return carts.any((element) => element.productId == productId);
    } else
      return false;
  }

  //get total products in cart
  Future<int> getTotalProductsInCart(int id) async {
    return 0;
  }

  //[POST] - add product to cart
  Future<bool> addCarts(Product product, int quantity) async {
    prefs = await SharedPreferences.getInstance();
    List<String> listCart = await prefs.getStringList('my-list-cart') ?? [];
    List<Cart> carts = [];
    if (listCart != []) {
      for (var itemCart in listCart) {
        Cart cart = Cart.fromJson(jsonDecode(itemCart));
        carts.add(cart);
      }
    }
    DateTime now = DateTime.now();
    Cart cart = new Cart(
        created: now,
        productId: product.id,
        quantity: quantity,
        price: product.price,
        image: product.image,
        name: product.name);
    carts.add(cart);
    List<String> lstStrCart = [];
    carts.forEach((cartItem) {
      String strCart = jsonEncode(cartItem);
      lstStrCart.add(strCart);
    });
    return await prefs.setStringList('my-list-cart', lstStrCart);
  }

  //[PUT] - update product to cart
  Future<bool> updateCarts(Product product, int quantity, bool isAdd) async {
    prefs = await SharedPreferences.getInstance();
    List<String> listCart = await prefs.getStringList('my-list-cart') ?? [];
    List<Cart> carts = [];
    if (listCart != []) {
      for (var itemCart in listCart) {
        Cart cart = Cart.fromJson(jsonDecode(itemCart));
        carts.add(cart);
      }
    }
    Cart cart = carts.firstWhere((cart) => cart.productId == product.id);
    if (isAdd) {
      cart.quantity = cart.quantity + quantity;
    } else {
      cart.quantity = cart.quantity - quantity;
    }
    carts[carts.indexWhere((cart) => cart.productId == product.id)] = cart;
    List<String> lstStrCart = [];
    carts.forEach((cartItem) {
      String strCart = jsonEncode(cartItem);
      lstStrCart.add(strCart);
    });
    return await prefs.setStringList('my-list-cart', lstStrCart);
  }

  //[DELETE] - remove product from cart
  Future<bool> deleteProductInCart(int productId) async {
// check
    prefs = await SharedPreferences.getInstance();
    List<String> listCart = await prefs.getStringList('my-list-cart') ?? [];
    listCart.removeWhere(
        (cart) => Cart.fromJson(jsonDecode(cart)).productId == productId);
    prefs.setStringList('my-list-cart', listCart);
    return true;
  }

  Future<bool> deleteAllCarts() async {
    prefs = await SharedPreferences.getInstance();
    final result = await prefs.remove('my-list-cart');
    print('tinh trang xoa gio hang :" $result');
    return result;
  }
}
