// ignore_for_file: use_build_context_synchronously

import 'package:app_food_mobile/repositories/auth_repository.dart';
import 'package:app_food_mobile/viewmodels/Users/user_view_model.dart';
import 'package:app_food_mobile/views/auth/register_page.dart';
import 'package:app_food_mobile/views/pages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../components/login_form.dart';
import '../../components/social_card.dart';
import '../../constants.dart';

class LoginScreen extends StatefulWidget {
  // final VoidCallback showRegisterPage;
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login(String username, String password) async {
    bool result = await AuthRepo().loginRepo(username, password);
    print(result);
    if (result) {
      AuthRepo.isLogin = true;
      await Provider.of<UserViewModel>(context, listen: false)
          .getInfoUser()
          .then((_) {
        PersistentNavBarNavigator.pushNewScreenWithRouteSettings(
          context,
          settings: RouteSettings(name: '/'),
          screen: MainPage(),
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      });
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "LỖI",
        desc: "Đăng nhập không thành công",
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            width: 120,
            child: Text(
              "Quay lại",
              style: Theme.of(context)
                  .textTheme
                  .headline3
                  ?.apply(color: kWhiteColor),
            ),
          )
        ],
      ).show();
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
        title: Text(
          'Đăng nhập',
          // style: Theme.of(context)
          //     .appBarTheme
          //     .textTheme
          //     ?.headline6
          //     ?.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
          child: Center(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
                child: Column(
              children: [
                //title login
                Container(
                  margin: EdgeInsets.only(bottom: defaulMargin * 2),
                  child: Column(
                    children: [
                      Text(
                        "Chào mừng đến với FoodApp",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text(
                        "Đăng nhập bằng tài khoản của bạn để đặt hàng",
                        style: Theme.of(context).textTheme.headline3,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SignForm(
                  login: () {
                    login(_usernameController.text, _passwordController.text);
                  },
                  emailController: _usernameController,
                  passwordController: _passwordController,
                ),
                Container(
                  margin: EdgeInsets.only(top: defaulMargin),
                  child: Row(
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
                ),
                SizedBox(height: MediaQuery.of(context).size.width * 0.08),
                //no - account - text
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Bạn không có tài khoản?",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.pushNamed(context, '/sign-up');
                        PersistentNavBarNavigator
                            .pushNewScreenWithRouteSettings(
                          context,
                          settings: RouteSettings(name: '/sign-up'),
                          screen: RegisterScreen(),
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                        );
                      },
                      child: Text(
                        "Đăng ký",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.apply(color: kPrimaryColor),
                      ),
                    ),
                  ],
                )
              ],
            )),
          ),
        ),
      )),
    );
  }
}
