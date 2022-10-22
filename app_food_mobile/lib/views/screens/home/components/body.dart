import 'package:app_food_mobile/models/product.dart';
import 'package:app_food_mobile/services/product_services.dart';
import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'category_list.dart';
import 'discount_cart.dart';
import 'list_item_card.dart';
import 'search.dart';

class Body extends StatefulWidget {
  Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late Future<List<Product>> listProducts;
  late List<Product> products = [];
  @override
  void initState() {
    super.initState();
    getProducts();
  }

  void getProducts() async {
    listProducts = ProductServices().getProducts();
    products = await listProducts;
    print(products);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Search(),
          CategoryList(),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: ListItemCard(
              products: products,
            ),
          ),
          DiscountCard()
        ],
      ),
    );
  }
}
