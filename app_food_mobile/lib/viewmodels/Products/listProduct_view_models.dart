import 'dart:convert';

import 'package:app_food_mobile/services/product_services.dart';
import 'package:app_food_mobile/viewmodels/Products/product_view_models.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ListProductsViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _productsDemand = [];
  List<Product> get products => _products;
  List<Product> get productsDemand => _productsDemand;
  ListProductsViewModel() {
    getProducts();
  }
  //duyen test
  Future<List<Product>> getListProduct() async {
    print('@@@@@');
    List<Product> products = (await ProductServices().getProducts());
    return products;
  }

  void getProducts() async {
    List<Product> products = (await ProductServices().getProducts());
    _products = products;
    _productsDemand =
        _products.where((product) => product.category == 4).toList();
    print('duyen check');
    print(_productsDemand.length);
    notifyListeners();
  }

  void getProductsByDemand(int idDemand) async {
    print('demand: $idDemand');
    List<Product> proDemand =
        _products.where((product) => product.category == idDemand).toList();
    print('product demand: ${proDemand.toString()}');
    _productsDemand = proDemand;
    print('check product demand: $_productsDemand');
    notifyListeners();
  }

  bool sortProductByDemand(int demand) {
    if (demand == 0) {
      _productsDemand.sort(
        (a, b) => b.price.compareTo(a.price),
      );
    } else {
      _productsDemand.sort(
        (a, b) => a.price.compareTo(b.price),
      );
    }

    return true;
  }

  Product getProductById(int id) {
    Product product;
    product = _products.firstWhere((product) => product.id == id);
    return product;
  }
}
