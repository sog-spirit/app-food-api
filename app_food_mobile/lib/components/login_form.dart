// ignore_for_file: must_be_immutable

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
        SizedBox(height: defaulMargin),
        buildPasswordFormField(),
        Container(
          margin: EdgeInsets.symmetric(vertical: defaulMargin),
          child: Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {},
              ),
              Text(
                "Ghi nhớ tài khoản",
                style: Theme.of(context).textTheme.headline5,
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "Forgot Password",
                  style: Theme.of(context)
                      .textTheme
                      .headline5
                      ?.apply(decoration: TextDecoration.underline),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          press: login,
          text: "Đăng nhập",
        )
      ]),
    );
  }

  //email text form field
  TextFormField buildEmailFormField() {
    return TextFormField(
      controller: emailController,
      style: TextStyle(color: kBlackColor),
      decoration: InputDecoration(
        labelText: "Username",
        hintText: "Nhập username",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }

  //password text form field
  TextFormField buildPasswordFormField() {
    return TextFormField(
      controller: passwordController,
      obscureText: true,
      validator: (value) {
        return null;
      },
      style: TextStyle(color: kBlackColor),
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter your password",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }
}
