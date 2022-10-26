import 'package:flutter/material.dart';

import '../../../../../models/product.dart';
import '../../../details/detail_page.dart';
import 'item_card.dart';

class ListItemCard extends StatelessWidget {
  ListItemCard({Key? key, required this.products}) : super(key: key);
  List<Product> products;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 260,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: products.length,
          itemBuilder: (context, index) {
            return ItemCard(
                product: products[index],
                press: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return DetailScreen(
                        product: products[index],
                      );
                    },
                  ));
                });
          },
        ));
  }
}
