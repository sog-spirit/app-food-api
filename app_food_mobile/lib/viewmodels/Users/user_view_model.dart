// ignore_for_file: prefer_interpolation_to_compose_strings, avoid_print, unused_field

import 'package:app_food_mobile/models/order_item.dart';
import 'package:app_food_mobile/repositories/user_repository.dart';
import 'package:flutter/material.dart';
import '../../models/order.dart';
import '../../models/productOrder.dart';
import '../../models/user.dart';
import '../../repositories/auth_repository.dart';

class UserViewModel extends ChangeNotifier {
  User? _currentUser;
  List<Order> _orders = [];
  List<OrderItem> _orderItems = [];
  bool _statusLogin = false;
  User? get currentUserModel => _currentUser;
  bool get statusLoginViewModel => _statusLogin;
  List<Order> get ordersUserModel => _orders;
  List<OrderItem> get orderItemUseModel => _orderItems;
  int _totalPriceOrderItem = 0;
  int get totalPriceOrderItem => _totalPriceOrderItem;

  UserViewModel() {
    // getInfoUser();
  }

  //check is existed user
  bool isLogin() {
    _statusLogin = true;
    notifyListeners();
    return (currentUserModel != null) ? true : false;
  }

  getInfoUser() async {
    print('hmmmm ');
    _statusLogin = true;
    _currentUser = await UserRepo().getUser();
    print('sau khi dang nhap:${currentUserModel.toString()}');
    notifyListeners();
  }

  Future<bool> updateUser(String newValue, String label) async {
    bool statusUpdate = await UserRepo().updateUser(newValue, label);
    if (statusUpdate) {
      await getInfoUser();
      return statusUpdate;
    }
    return false;
  }

  Future<bool> updatePassword(String currentPW, String newPW) async {
    return await UserRepo().updatePassword(currentPW, newPW);
  }

  Future<bool> checkLogined() async {
    var status = await AuthRepo().checkLogined();
    if (status) {
      _statusLogin = true;
    } else {
      _statusLogin = false;
    }
    notifyListeners();
    return status;
  }

  Future<bool> logout() async {
    _currentUser = null;
    _statusLogin = false;
    notifyListeners();
    return await AuthRepo().logout();
  }

  Future<bool> order(List<ProductOrder> lstOrders, String address) async {
    if (currentUserModel == null) return false;
    if (address.isEmpty) {
      address = currentUserModel!.address;
    }
    bool statusOrder =
        await UserRepo().orderProducts(lstOrders, currentUserModel!, address);
    if (statusOrder) {
      await getOrders().then((_) {
        return statusOrder;
      });
    }
    return statusOrder;
    // return await UserRepo().orderProducts(products, currentUserModel!);
  }

  Future<void> getOrders() async {
    List<Order> orders = await UserRepo().getOrders();
    _orders = orders;
    notifyListeners();
  }

  Future<void> getOrderItems(int orderId) async {
    List<OrderItem> orderItems = await UserRepo().getDetailOrder(orderId);
    if (orderItems != []) {
      int total = orderItems
          .map<int>((cart) => cart.quantity * cart.price.toInt())
          .reduce((value1, value2) => value1 + value2);
      _totalPriceOrderItem = total;
    } else {
      _totalPriceOrderItem = 0;
    }
    _orderItems = orderItems;
    notifyListeners();
  }
}
