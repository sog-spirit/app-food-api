import 'dart:convert';

import 'package:app_food_mobile/repositories/cart_repositiory.dart';
import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart.dart';
import '../../models/product.dart';

List<String> hjdf = ['hdhe', 'hhgfg'];

class CartViewModel extends ChangeNotifier {
  List<Cart> _cartListModel = [];
  List<Cart> get cartListModel => _cartListModel;
  late ListProductsViewModel listProductViewModel;
  int _totalProduct = 0;
  int _totalPrice = 0;
  int _numProduct = 0;
  int get totalProduct => _totalProduct;
  int get numProduct => _numProduct;
  int get totalPrice => _totalPrice;
  late SharedPreferences prefs;
  CartViewModel() {
    fetchAndSetCart();
  }

  setCartListModel(List<Cart> cartListModel) async {
    _cartListModel = cartListModel;
    notifyListeners();
  }

  setTotalProductCart(int totalProduct) async {
    _totalProduct = totalProduct;
    notifyListeners();
  }

  setTotalPriceCart(int totalPrice) async {
    _totalPrice = totalPrice;
    print(': $_totalPrice');
    notifyListeners();
  }

  fetchAndSetCart() async {
    try {
      List<Cart> carts = (await CartRepository().getCarts());
      if (carts.isEmpty) {
        _cartListModel = [];
        _totalProduct = 0;
        _totalPrice = 0;
        _numProduct = 0;
      } else {
        _cartListModel = carts;
        _totalProduct = getTotalProductInCart();
        _totalPrice = getTotalPrice();
        _numProduct = carts.length;
      }
      notifyListeners();
    } catch (err) {
      print('error in fetch cart: ${err}');
    }
  }

  // Future<bool> checkProductInCart(int userId, int productId) async {
  //   bool isProductInCart =
  //       await CartRepository().checkProductInCart(userId, productId);
  //   print('duyen');
  //   return isProductInCart;
  // }

  //total product in cart
  int getTotalProductInCart() {
    int total = 0;
    print(
        'total product in cart : $cartListModel ---- ${cartListModel.length}');
    if (cartListModel != []) {
      try {
        var test = cartListModel.map<int>((item) => item.quantity).toList();
        total = test.reduce((a, b) => a + b);
        return total;
      } catch (err) {
        print('error3333: ' + err.toString());
        return 0;
      }
    }
    return 2;
  }

  //total price in cart
  int getTotalPrice() {
    int total = 0;
    if (cartListModel != []) {
      total = cartListModel
          .map<int>((cart) => cart.quantity * cart.price.toInt())
          .reduce((value1, value2) => value1 + value2);
      return total;
    } else {
      return 0;
    }
  }

  updateCart(Product product, int quantity, bool isAdd) async {
    bool statusProduct = await CartRepository().checkProductInCart(product.id);
    print(statusProduct);
    if (statusProduct) {
      editCarts(product, quantity, isAdd);
    } else {
      await addCarts(product, quantity);
    }
  }

  addCarts(Product product, int quantity) async {
    await CartRepository().addCarts(product, quantity);
    await fetchAndSetCart();
  }

  editCarts(Product product, int quantity, bool isAdd) async {
    await CartRepository().updateCarts(product, quantity, isAdd);
    await fetchAndSetCart();
  }

  deleteProductInCart(int productId) async {
    print('cart view modelllll');
    await CartRepository().deleteProductInCart(productId);
    await fetchAndSetCart();
  }

  deleteAllCarts() async {
    await CartRepository().deleteAllCarts();
    await fetchAndSetCart();
  }

  Cart getCartIdByProduct(int productId) {
    Cart cart = [...cartListModel.where((e) => e.productId == productId)][0];
    return cart;
  }
}
