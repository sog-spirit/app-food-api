import 'package:flutter/material.dart';

// const baseApi = "http://192.168.31.142:8000/";s
const baseApi = "https://web-production-746d.up.railway.app/";

const kPrimaryColor = Color(0xFFD10A1F);
const ksecondaryColor = Color(0xFF676C72);
const kLightSecondaryColor = Color(0xBABAC5);
const kHoverSecondaryColor = Color(0xFFC3C6CC);
const kDivideColor = Color(0xFFECEEF1);
const kGreyIconColor = Color(0xFF737373);

const kGreyBackgroundColor = Color(0xFFEEEEEE);

const kBlackColor = Colors.black;
const kLightBlackColor = Color(0xFF3C4347);
const kWhiteColor = Colors.white;
const kTextGreyColor = Color(0xFF797982);
const kTextLightColor = Color(0xFF6A727D);

const kPrimaryColor2 = Color(0xFFFF7643);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFA53E), Color(0xFFFF7643)],
);
const kDarkPrimaryColor = Color.fromARGB(255, 222, 222, 222);

const kAnimationDuration = Duration(milliseconds: 200);

const double defaultPadding = 16.0;
const double defaultBorderRadius = 6.0;
const double defaultSizeboxHeight = 15.0;
const double defaulMargin = 16.0;

final headingLagerStyle = TextStyle(
    height: 1.2, fontSize: 22, fontWeight: FontWeight.w500, color: kBlackColor);

const defaultDuration = Duration(milliseconds: 250);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";
