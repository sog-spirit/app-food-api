// ignore_for_file: use_build_context_synchronously

import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'default_button.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm(
      {super.key,
      required this.register,
      required this.usernameController,
      required this.passwordController,
      required this.passwordConfirmController});
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController passwordConfirmController;
  final VoidCallback register;
  bool remember = false;

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        BuildTextField(
          controller: usernameController,
          hintText: "Nhập username của bạn",
          labelText: "Username",
          editTex: () {},
          iconText: "Mail.svg",
        ),
        SizedBox(height: 30),
        BuildTextField(
          controller: passwordController,
          hintText: "Nhập mật khẩu của bạn",
          labelText: "Mật khẩu",
          editTex: () {},
          iconText: "Lock.svg",
        ),
        SizedBox(height: 30),
        BuildTextField(
          controller: passwordConfirmController,
          hintText: "Nhập mật lại mật khẩu",
          labelText: "Nhập mật",
          editTex: () {},
          iconText: "Lock.svg",
        ),
        SizedBox(height: 30),
        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          // press: register,
          press: () {
            register();
          },
          text: "Thông tin chi tiết",
        )
      ]),
    );
  }
}

class BuildTextField extends StatelessWidget {
  const BuildTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.iconText,
    required this.editTex,
    required this.controller,
  });
  final String labelText, hintText, iconText;
  final Function editTex;
  // final TextEditingController controller;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        // readOnly: true,
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: IconButton(
              icon: SvgPicture.asset(
                "assets/icons/$iconText",
                height: 19,
              ),
              onPressed: () {
                editTex();
              },
            )));
  }
}
