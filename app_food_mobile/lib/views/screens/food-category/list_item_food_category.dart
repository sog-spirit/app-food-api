import 'package:app_food_mobile/views/screens/food-category/item_food_category.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../models/product.dart';
import '../../../viewmodels/Products/listProduct_view_models.dart';

class ListItemFoodCategory extends StatelessWidget {
  const ListItemFoodCategory({super.key, required this.proCategory});
  final int proCategory;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: 800,
          child: Consumer<ListProductsViewModel>(
              builder: (context, provider, child) => ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: provider.productsDemand.length,
                    itemBuilder: (context, index) {
                      Product product = provider.productsDemand[index];
                      return ItemFoodCategory(
                        product: product,
                      );
                    },
                  ))),
    );
  }
}
