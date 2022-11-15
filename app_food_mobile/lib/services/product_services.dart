import 'dart:convert';

import 'package:app_food_mobile/constants.dart';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  //get all product
  Future<List<Product>> getProducts() async {
    var client = http.Client();
    var url = Uri.parse("${baseApi}api/product");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      return productFromJson(json);
    } else {
      return [];
    }
  }
}
