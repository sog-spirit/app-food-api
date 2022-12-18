import 'package:app_food_mobile/components/register_form.dart';
import 'package:app_food_mobile/views/auth/register_information.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../components/login_form.dart';
import '../../components/social_card.dart';
import '../../constants.dart';
import 'login_page.dart';

class RegisterScreen extends StatefulWidget {
  // final VoidCallback showLoginPage;
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Resgister',
          style: Theme.of(context)
              .appBarTheme
              .textTheme
              ?.headline6
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
              child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.width * 0.04,
              ),
              Text(
                "Đăng ký tài khoản",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 10),
              Text(
                "Hoàn thành thông tin chi tiết của bạn",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.08),
              RegisterForm(
                register: () {
                  // Navigator.pushNamed(context, '/sign-up/detail-info',
                  //     arguments: [
                  //       (_usernameController.text),
                  //       (_passwordController.text)
                  //     ]);
                  PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                    context,
                    settings: RouteSettings(name: '/food-category'),
                    screen: RegisterInformationScreen(
                        password: _passwordConfirmController.text,
                        username: _usernameController.text),
                    withNavBar: true,
                    pageTransitionAnimation: PageTransitionAnimation.cupertino,
                  );
                },
                usernameController: _usernameController,
                passwordController: _passwordController,
                passwordConfirmController: _passwordConfirmController,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.08),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialCard(
                    icon: "assets/icons/google-icon.svg",
                    press: () {},
                  ),
                  SocialCard(
                    icon: "assets/icons/facebook-2.svg",
                    press: () {},
                  ),
                  SocialCard(
                    icon: "assets/icons/twitter.svg",
                    press: () {},
                  )
                ],
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.08),
              //no - account - text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have you had an account? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, '/sign-in');
                      PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
                        context,
                        settings: RouteSettings(name: '/sign-in'),
                        screen: LoginScreen(),
                        withNavBar: false,
                        pageTransitionAnimation:
                            PageTransitionAnimation.cupertino,
                      );
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(fontSize: 16, color: kPrimaryColor),
                    ),
                  ),
                ],
              )
            ],
          )),
        ),
      )),
    );
  }
}
