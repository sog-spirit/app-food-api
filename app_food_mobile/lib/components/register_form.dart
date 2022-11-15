import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'default_button.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm(
      {super.key,
      required this.register,
      required this.emailController,
      required this.passwordController,
      required this.passwordConfirmController});
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final VoidCallback register;
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
        buildPasswordConfirmFormField(),
        SizedBox(height: 30),
        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          press: register,
          text: "Continue",
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

  //password confirm text form field
  TextFormField buildPasswordConfirmFormField() {
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
        hintText: "Re-enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
