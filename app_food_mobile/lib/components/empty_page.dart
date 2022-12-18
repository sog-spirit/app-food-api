import 'package:flutter/material.dart';

import '../constants.dart';

class EmptyPage extends StatelessWidget {
  const EmptyPage({
    Key? key,
    required this.label,
    required this.content,
    required this.btnText,
    required this.funcBtn,
  }) : super(key: key);
  final String label, content, btnText;
  final VoidCallback funcBtn;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      height: double.infinity,
      width: double.infinity,
      child: Column(children: [
        //image
        SizedBox(
          width: 300,
          height: 300,
          child: Image.asset('assets/images/no_cart.png'),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.apply(color: kPrimaryColor),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          content,
          style: Theme.of(context).textTheme.headline4,
        ),
        SizedBox(
          height: 20,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: kPrimaryColor,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: TextButton(
            onPressed: () {
              funcBtn();
            },
            child: Text(
              btnText,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
