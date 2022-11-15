import 'package:app_food_mobile/services/product_services.dart';
import 'package:app_food_mobile/viewmodels/Products/product_view_models.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ListProductsViewModel extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> get products => _products;
  ListProductsViewModel() {
    getProducts();
  }
  void getProducts() async {
    List<Product> products = (await ProductServices().getProducts());
    _products = products;
    notifyListeners();
    print(_products);
  }
}
