import 'package:app_food_mobile/viewmodels/Products/product_view_models.dart';
import 'package:app_food_mobile/views/screens/food-category/food_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../constants.dart';
import '../../../viewmodels/Products/listProduct_view_models.dart';

class ListIconFoodCategory extends StatelessWidget {
  const ListIconFoodCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconFoodCategory(
            categoryId: 0,
            imageIcon: "all_category",
            textIcon: "All",
          ),
          IconFoodCategory(
            categoryId: 3,
            imageIcon: "burger_category",
            textIcon: "Burger",
          ),
          IconFoodCategory(
            categoryId: 4,
            imageIcon: "rice_category",
            textIcon: "Cơm",
          ),
          IconFoodCategory(
            categoryId: 1,
            imageIcon: "chicken_category",
            textIcon: "Gà",
          ),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconFoodCategory(
            categoryId: 4,
            imageIcon: "spagety_category",
            textIcon: "Mì Ý",
          ),
          IconFoodCategory(
            categoryId: 2,
            imageIcon: "ff_category",
            textIcon: "Ăn Vặt",
          ),
          IconFoodCategory(
            categoryId: 2,
            imageIcon: "drink_category",
            textIcon: "Đồ uống",
          ),
        ],
      )
    ]);
  }
}

class IconFoodCategory extends StatelessWidget {
  const IconFoodCategory(
      {super.key,
      required this.imageIcon,
      required this.textIcon,
      required this.categoryId});
  final String imageIcon, textIcon;
  final int categoryId;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<ListProductsViewModel>(context, listen: false)
            .getProductsByDemand(categoryId);
        // ignore: dead_code
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: '/food-category'),
          screen: FoodCategoryScreen(
            proCategory: categoryId,
            proLabel: textIcon,
          ),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
      child: Column(children: [
        Image(
          image: AssetImage('assets/images/$imageIcon.png'),
        ),
        Text(
          textIcon,
          style: TextStyle(
            color: kPrimaryColor,
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
    );
  }
}
