import 'dart:io';
import 'dart:typed_data';

import 'package:app_food_mobile/viewmodels/Carts/cart_view_model.dart';
import 'package:app_food_mobile/viewmodels/Products/listProduct_view_models.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/auth/login_page.dart';
import 'package:app_food_mobile/views/auth/register_information.dart';
import 'package:app_food_mobile/views/auth/register_page.dart';
import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:app_food_mobile/views/screens/cart/cart_page.dart';
import 'package:app_food_mobile/views/screens/cart/checkout_page.dart';
import 'package:app_food_mobile/views/screens/details/detail_page.dart';
import 'package:app_food_mobile/views/screens/food-category/food_category_screen.dart';
import 'package:app_food_mobile/views/screens/home/components/icon_btn/search.dart';
import 'package:app_food_mobile/views/screens/home/search_page.dart';
import 'package:app_food_mobile/views/screens/order/order_detail.dart';
import 'package:app_food_mobile/views/screens/order/order_page.dart';
import 'package:app_food_mobile/views/screens/users/change_password_page.dart';
import 'package:app_food_mobile/views/screens/users/edit_user_page.dart';
import 'package:app_food_mobile/views/screens/users/pass_word.dart';
import 'package:app_food_mobile/views/screens/users/user_login.dart';
import 'package:app_food_mobile/views/screens/users/phone_number_page.dart';
import 'package:app_food_mobile/views/screens/users/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'models/product.dart';
import 'theme.dart';
import 'views/screens/home/home_page.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartViewModel()),
          ChangeNotifierProvider(create: (_) => ListProductsViewModel()),
          ChangeNotifierProvider(create: (_) => UserViewModel()),
        ],
        child: MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: themeData(),
            routes: {
              '/': (context) => MainPage(),
              '/sign-in': (context) => LoginScreen(),
              '/sign-up': (context) => RegisterScreen(),
              '/home': (context) => HomePage(),
              '/search': (context) => SearchScreen(),
              '/cart': (context) => CartPage(),
              '/cart/checkout': (context) => CheckoutPage(),
              '/orders': (context) => OrderPage(),
              '/profile': (context) => UserProfile(),
              '/profile/edit': (context) => EditUserPage(),
              '/profile/change-password': (context) => ChangePasswordPage(),
              '/profile/phone-number': ((context) => PhoneNumberPage()),
              '/profile/password': ((context) => PasswordPage()),
              '/user': ((context) => UserLogin()),
            },
            onGenerateRoute: (settings) {
              if (settings.name == '/detail-product') {
                Product args = settings.arguments as Product;
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      DetailScreen(
                    product: args,
                  ),
                  settings: settings,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              }
              if (settings.name == '/sign-up/detail-info') {
                List<String> args = settings.arguments as List<String>;
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      RegisterInformationScreen(
                    username: args[0],
                    password: args[1],
                  ),
                  settings: settings,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              }
              if (settings.name == '/order/order-detail') {
                int orderId = settings.arguments as int;
                return PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      OrderDetail(
                    orderId: orderId,
                  ),
                  settings: settings,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          FadeTransition(
                    opacity: animation,
                    child: child,
                  ),
                );
              }
              if (settings.name == '/food-category') {
                // List<String> args = settings.arguments as List<String>;
                // return PageRouteBuilder(
                //   pageBuilder: (context, animation, secondaryAnimation) =>
                //       FoodCategoryScreen(
                //     proCategory: categoryId,
                //   ),
                //   settings: settings,
                //   transitionsBuilder:
                //       (context, animation, secondaryAnimation, child) =>
                //           FadeTransition(
                //     opacity: animation,
                //     child: child,
                //   ),
                // );
              }
            }));
  }
}
