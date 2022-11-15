import 'package:app_food_mobile/constants.dart';
import 'package:flutter/material.dart';
import 'default_button.dart';
import 'custom_surfix_icon.dart';
import 'form_error.dart';

class RegisterInforForm extends StatelessWidget {
  RegisterInforForm(
      {super.key,
      required this.register,
      required this.firstNameController,
      required this.lastNameController,
      required this.phoneController,
      required this.addressController});
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController phoneController;
  final TextEditingController addressController;
  final VoidCallback register;
  bool remember = false;

  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(children: [
        buildFirstnameFormField(),
        SizedBox(height: 30),
        buildLastnameFormField(),
        SizedBox(height: 30),
        buildNumberphoneFormField(),
        SizedBox(height: 30),
        buildAddressFormField(),
        FormError(errors: errors),
        SizedBox(height: 15),
        DefaultButton(
          press: register,
          text: "Register",
        )
      ]),
    );
  }

  //firstname text form field
  TextFormField buildFirstnameFormField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "First Name",
        hintText: "Enter your first name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/person.svg"),
      ),
    );
  }

  //lastname text form field
  TextFormField buildLastnameFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your last name",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/person.svg"),
      ),
    );
  }

  //password confirm text form field
  TextFormField buildNumberphoneFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: "Phone Number",
        hintText: "Enter your phone number",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Phone.svg"),
      ),
    );
  }

  //address text form field
  TextFormField buildAddressFormField() {
    return TextFormField(
      obscureText: true,
      onChanged: (value) {
        return null;
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
        labelText: "Address",
        hintText: "Enter your address",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/map.svg"),
      ),
    );
  }
}
