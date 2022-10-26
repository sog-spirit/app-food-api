import 'dart:convert';

import '../models/product.dart';
import 'package:http/http.dart' as http;

class ProductServices {
  //get all product
  Future<List<Product>> getProducts() async {
    var client = http.Client();
    var url = Uri.parse("http://192.168.1.4:8000/api/product");
    var response = await client.get(url);
    if (response.statusCode == 200) {
      var json = utf8.decode(response.bodyBytes);
      print('dyen xink');
      return productFromJson(json);
    } else {
      print('dyen ngu');
      return [];
    }
  }
}
