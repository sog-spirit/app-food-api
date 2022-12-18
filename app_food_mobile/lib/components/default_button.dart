import 'package:flutter/material.dart';

import '../constants.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({super.key, required this.text, required this.press});
  final String text;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return   SizedBox(
        width: double.infinity,
        height: 45,
        child: TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          onPressed: press,
        child: Text(
            text,
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ));
  }
}
