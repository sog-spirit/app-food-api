import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

AppBar HomeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/menu.svg"),
      onPressed: () {},
    ),
    title: Center(
      child: RichText(
          text: TextSpan(
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: const [
            TextSpan(text: "Punk", style: TextStyle(color: ksecondaryColor)),
            TextSpan(text: "Food", style: TextStyle(color: kPrimaryColor)),
          ])),
    ),
    actions: [
      IconButton(
        icon: SvgPicture.asset("assets/icons/notification.svg"),
        onPressed: () {
            Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => CartScreen()));
        },
      )
    ],
  );
}
