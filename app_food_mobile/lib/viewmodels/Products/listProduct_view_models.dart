import 'package:app_food_mobile/services/product_services.dart';
import 'package:app_food_mobile/viewmodels/Products/product_view_models.dart';
import 'package:flutter/material.dart';

import '../../models/product.dart';

class ListProductsViewModel with ChangeNotifier {
  List<ProductViewModel> products = [];

  void getProducts() async {
    List<ProductViewModel> _products =
        (await ProductServices().getProducts()).cast<ProductViewModel>();
    notifyListeners();
    print('duyen dang debug');
    print(_products);
  }
}
