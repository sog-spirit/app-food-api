// ignore_for_file: implementation_imports
// ignore: unused_import
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import '../auth/login/login_page.dart';
import '../auth/register/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLoginScreen = true;
  void toggleScreen() {
    setState(() {
      showLoginScreen = !showLoginScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginScreen) {
      return LoginScreen(showRegisterPage: toggleScreen);
    } else {
      return RegisterScreen(showLoginPage: toggleScreen);
    }
  }
}
