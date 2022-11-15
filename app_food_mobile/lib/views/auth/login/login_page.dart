import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../../components/login_form.dart';
import '../../../components/social_card.dart';
import '../../../constants.dart';
import '../../screens/home/home_page.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginScreen({super.key, required this.showRegisterPage});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void login(String username, String password) async {
    print("login2332");
    //xu ly login
    try {
      Response response = await post(Uri.parse("${baseApi}api/user/login"),
          body: {"username": "admin", "password": "admin"});
      if (response.statusCode == 200) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        print('failed');
      }
    } catch (e) {
      print('failedsdfds');
      print(e.toString());
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Login',
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
                "Welcome Back",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                "Sign in with your email and password  \nor continue with social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MediaQuery.of(context).size.width * 0.08),
              SignForm(
                login: () {
                  login(_emailController.text.toString(),
                      _passwordController.text.toString());
                },
                emailController: _emailController,
                passwordController: _passwordController,
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
                    "Don't have an account ? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(
                      "Sign Up",
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
