// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../models/cart.dart';
import '../../services/cart_services.dart';

class CartViewModel extends ChangeNotifier {
  bool _loading = false;
  List<Cart> _cartListModel = [];
  bool get loading => _loading;
  List<Cart> get cartListModel => _cartListModel;
  int _totalProduct = 0;
  int get TotalProduct => _totalProduct;

  CartViewModel() {
    getCarts(1);
  }

  setLoading(bool loading) async {
    _loading = loading;
    notifyListeners();
  }

  setCartListModel(List<Cart> cartListModel) async {
    _cartListModel = cartListModel;
    print('set carts');
    notifyListeners();
  }

  setTotalProductCart(int totalProduct) async {
    _totalProduct = totalProduct;
    print('set carts');
    notifyListeners();
  }

  getCarts(int id) async {
    setLoading(true);
    List<Cart> carts = (await CartServices().getCarts(id));
    if (carts != []) {
      await setCartListModel(carts);
      await setTotalProductCart(getTotalProductInCart());
      setLoading(false);
    } else {
      print('error');
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
    if (cartListModel != []) {
      try {
        // total = cartListModel
        //     .map<int>((item) => item.quantity)
        //     .reduce((value1, value2) => value1 + value2);
        print('co loi trong get total product trong cart');
        total = 5;
        return total;
      } catch (err) {
        print('error3333: ' + err.toString());
        return 0;
      }
      return total;
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
    await getCarts(1);
  }

  editCarts(int userId, int cartId, int quantity) async {
    await CartServices().updateCarts(userId, cartId, quantity);
    await getCarts(1);
  }

  void deleteCarts(int userId, int productId) async {
    await CartServices().deleteCarts(userId, productId);
    await getCarts(1);
    notifyListeners();
  }

  // get cartId by productId
  Cart getCartIdByProduct(int productId) {
    // try {
    //   Cart cart = [...cartListModel.where((e) => e.product == productId)][0];
    //   return cart;
    // } catch (err) {
    //   print('error in get cartid by product' + err.toString());
    //   return null;
    // }
    Cart cart = [...cartListModel.where((e) => e.product == productId)][0];
    return cart;
  }
}
