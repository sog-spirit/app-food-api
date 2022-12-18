import 'package:app_food_mobile/views/auth/login_page.dart';
import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';
import '../../../../viewmodels/Carts/cart_view_model.dart';
import 'icon_btn/icon_btn_counter.dart';

AppBar HomeAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: kPrimaryColor,
    primary: false,
    elevation: 0,
    title: Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Text("FoodApp",
          textAlign: TextAlign.left,
          style: TextStyle(
              color: kWhiteColor, fontWeight: FontWeight.bold, fontSize: 18)),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Row(children: [
          Consumer<CartViewModel>(
            builder: ((context, provider, child) {
              return IconBtnWithCounter(
                numOfItems: provider.numProduct,
                press: () {
                  // Navigator.pushNamed(context, "/cart");
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: '/cart'),
                    screen: CartPage(),
                    withNavBar: false,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                svgSrc: "assets/icons/Cart Icon.svg",
              );
            }),
          ),
          IconBtnWithCounter(
              press: () {}, svgSrc: "assets/icons/Bell.svg", numOfItems: 2),
        ]),
      ),
    ],
  );
}
