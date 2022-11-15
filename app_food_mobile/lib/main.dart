import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:app_food_mobile/viewmodels/Products/product_view_models.dart';
import 'package:app_food_mobile/views/screens/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartViewModel()),
          ChangeNotifierProvider(create: (_) => ListProductsViewModel())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: themeData(),
          home: WelcomeScreen(),
        ));
  }
}
