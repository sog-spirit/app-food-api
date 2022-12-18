import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Lato",
    textTheme: textTheme,
    appBarTheme: appBarTheme(),
    inputDecorationTheme: inputDecorationTheme(),
  );
}

InputDecorationTheme inputDecorationTheme() {
  return InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextGreyColor),
          gapPadding: 5),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide(color: kTextGreyColor),
          gapPadding: 1),
      contentPadding: EdgeInsets.symmetric(horizontal: 30, vertical: 0));
}

// TextTheme textTheme() {
//   return TextTheme(
//     bodyText1: TextStyle(color: kTextGreyColor),
//     bodyText2: TextStyle(color: kTextGreyColor),
//     bodyMedium: TextStyle(color: Colors.yellow),
//     // bodyLarge: TextStyle(color: Colors.green),
//     // titleLarge: TextStyle(color: Color.fromARGB(255, 218, 153, 153)),
//     // titleMedium: TextStyle(color: Colors.pink)
//   );
// }

//duyen check
const typeTheme = Typography.blackCupertino;

TextTheme textTheme = Typography.blackCupertino.copyWith(
  bodyText1: typeTheme.bodyText1
      ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold, color: kBlackColor),
  bodyText2: typeTheme.bodyText2?.copyWith(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
  headline1: typeTheme.headline1
      ?.copyWith(fontSize: 24, fontWeight: FontWeight.w400, color: kBlackColor),
  headline2: typeTheme.headline2?.copyWith(
      color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
  headline3: typeTheme.headline3?.copyWith(
      fontSize: 16, fontWeight: FontWeight.w600, color: kTextGreyColor),
  headline4: typeTheme.headline4
      ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500, color: kBlackColor),
  headline5: typeTheme.headline5?.copyWith(fontSize: 14, color: kTextGreyColor),
  headline6: typeTheme.headline6?.copyWith(fontSize: 16, color: Colors.blue),
  subtitle1:
      typeTheme.subtitle1?.copyWith(fontSize: 18, color: kHoverSecondaryColor),
  subtitle2: typeTheme.subtitle2?.copyWith(fontSize: 21, color: Colors.cyan),
);

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: kPrimaryColor,
    elevation: 0,
    iconTheme: IconThemeData(color: kWhiteColor),
  );
}
