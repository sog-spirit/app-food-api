 import 'package:flutter/material.dart';

AppBar CartAppBar() {
    return AppBar(
          title: Column(
        children: const [
          Text(
            "Your Cart",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            "4 items",
            style: TextStyle(fontWeight: FontWeight.normal),
          )
        ],
      ));
  }
