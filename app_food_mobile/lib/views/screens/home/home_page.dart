import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:app_food_mobile/views/screens/order/order_page.dart';
import 'package:app_food_mobile/views/screens/users/user_page.dart';
import 'package:flutter/material.dart';
import 'components/app_bar.dart';
import 'components/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(context),
      body: HomeBody(),
    );
  }
}
