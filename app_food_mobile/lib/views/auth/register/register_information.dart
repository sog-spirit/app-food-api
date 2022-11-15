import 'package:app_food_mobile/components/register_infor_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../components/register_form.dart';
import '../../../components/social_card.dart';
import '../../../constants.dart';

class RegisterInformationScreen extends StatelessWidget {
  RegisterInformationScreen({super.key});
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _phoneNumberController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

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
              Text(
                "Complete Profile",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(
                "Complete your details information or countinue \n with your social media",
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              RegisterInforForm(
                register: () {},
                addressController: _addressController,
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                phoneController: _phoneNumberController,
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
              //no - account - text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: TextStyle(fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {},
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
