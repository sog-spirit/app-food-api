import 'package:flutter/material.dart';

AppBar CartAppBar() {
  return AppBar(
      backgroundColor: Colors.red,
      title: Column(
        children: const [
          Text(
            "Cart",
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w900, fontSize: 16),
          ),
        ],
      ));
}
