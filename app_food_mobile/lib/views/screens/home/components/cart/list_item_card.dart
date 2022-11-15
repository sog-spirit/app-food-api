import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../models/product.dart';
import '../../../details/detail_page.dart';
import 'item_card.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard({Key? key}) : super(key: key);
  //get fake cards

  void getCards() async {}
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 260,
          child: Consumer<ListProductsViewModel>(
              builder: (context, provider, child) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: provider.products.length,
                    itemBuilder: (context, index) {
                      return ItemCard(
                          product: provider.products[index],
                          press: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return DetailScreen(
                                  product: provider.products[index],
                                );
                              },
                            ));
                          });
                    },
                  ))),
    );
  }
}
