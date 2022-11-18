// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../../services/cart_services.dart';

class CartViewModel extends ChangeNotifier {
  List<Cart> _cartListModel = [];
  List<Cart> get cartListModel => _cartListModel;
  int _totalProduct = 0;
  int _totalPrice = 0;
  int get totalProduct => _totalProduct;
  int get totalPrice => _totalPrice;

  CartViewModel() {
    fetchAndSetCart(1);
  }

  setCartListModel(List<Cart> cartListModel) async {
    _cartListModel = cartListModel;
    print('set carts');
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

  fetchAndSetCart(int id) async {
    try {
      List<Cart> carts = (await CartServices().getCarts(id));
      _cartListModel = carts;
      _totalProduct = getTotalProductInCart();
      _totalPrice = getTotalPrice();
      notifyListeners();
    } catch (err) {
      print('error in fetch cart: ${err}');
    }
  }

  Future<bool> checkProductInCart(int userId, int productId) async {
    bool isProductInCart =
        await CartServices().checkProductInCart(userId, productId);
    print('duyen');
    print(isProductInCart);
    return isProductInCart;
  }

  //total product in cart
  int getTotalProductInCart() {
    int total = 0;
    var t = 0;
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
    return 0;
  }

  //total price in cart
  int getTotalPrice() {
    int total = 0;
    if (cartListModel != []) {
      total = cartListModel
          .map<int>((item) => item.quantity * item.price)
          .reduce((value1, value2) => value1 + value2);
      return total;
    } else {
      return 0;
    }
  }

  updateCart(int userId, int productId, int quantity) async {
    bool statusProduct =
        await CartServices().checkProductInCart(userId, productId);
    if (statusProduct) {
      // da ton tai
      print('cap nhat so luong moi');
      Cart cartExisted = this.getCartIdByProduct(productId);
      await this
          .editCarts(userId, cartExisted.id, quantity + cartExisted.quantity);
    } else {
      print('them moi');
      await this.addCarts(userId, productId, quantity);
    }
  }

  addCarts(int userId, int productId, int quantity) async {
    await CartServices().addCarts(userId, productId, quantity);
    await fetchAndSetCart(1);
  }

  editCarts(int userId, int cartId, int quantity) async {
    await CartServices().updateCarts(userId, cartId, quantity);
    await fetchAndSetCart(1);
  }

  void deleteCarts(int userId, int productId) async {
    await CartServices().deleteCarts(userId, productId);
    await fetchAndSetCart(1);
  }

  // get cartId by productId
  Cart getCartIdByProduct(int productId) {
    Cart cart = [...cartListModel.where((e) => e.product == productId)][0];
    return cart;
  }
}
                                                                                    