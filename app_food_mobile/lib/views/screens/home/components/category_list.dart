import 'package:flutter/material.dart';

import 'category_item.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          CategoryItem(
            title: "Combo Meal",
            isActive: true,
            press: () {},
          ),
          CategoryItem(
            title: "Ckicken",
            isActive: false,
            press: () {},
          ),
          CategoryItem(
            title: "Beveriages",
            isActive: false,
            press: () {},
          ),
          CategoryItem(
            title: "Snacks & Slides",
            isActive: false,
            press: () {},
          ),
        ],
      ),
    );
  }
}
