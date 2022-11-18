import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'default_button.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';

class SignForm extends StatelessWidget {
  SignForm(
      {super.key,
      required this.login,
      required this.emailController,
      required this.passwordController});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback login;
  bool remember = false;

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        buildEmailFormField(),
        SizedBox(height: 30),
        buildPasswordFormField(),
        SizedBox(height: 30),
        Row(
          children: [
            Checkbox(
              value: remember,
              activeColor: kPrimaryColor,
              onChanged: (value) {},
            ),
            Text("Remember me"),
            Spacer(),
            GestureDetector(
              onTap: () {},
              child: Text(
                "Forgot Password",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          press: login,
          text: "Login",
        )
      ]),
    );
  }

  //email text form field
  TextFormField buildEmailFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  //password text form field
  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
