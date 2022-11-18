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
      child: Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CategoryItem(
              title: "Cơm",
              isActive: true,
              press: () {},
            ),
            CategoryItem(
              title: "Burgur",
              isActive: false,
              press: () {},
            ),
            CategoryItem(
              title: "Đồ uống",
              isActive: false,
              press: () {},
            ),
            CategoryItem(
              title: "Gà",
              isActive: false,
              press: () {},
            ),
          ],
        ),
      ),
    
    
    );
  }
}
