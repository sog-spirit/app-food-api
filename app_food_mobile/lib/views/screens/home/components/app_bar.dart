import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';
import 'icon_btn/icon_btn_counter.dart';

AppBar HomeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: SvgPicture.asset("assets/icons/location.svg"),
      onPressed: () {},
    ),
    title: Text("BugFood",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
    actions: [
      Consumer<CartViewModel>(
        builder: ((context, provider, child) {
          return IconBtnWithCounter(
            numOfItems: provider.totalProduct,
            press: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => CartScreen()));
            },
            svgSrc: "assets/icons/Cart Icon.svg",
          );
        }),
      ),
      IconBtnWithCounter(
          press: () {}, svgSrc: "assets/icons/Bell.svg", numOfItems: 2),
      IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    ],
  );
}
