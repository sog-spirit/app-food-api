import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../constants.dart';

class Search extends StatelessWidget {
  const Search({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.65,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 222, 222, 222).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: TextField(
          decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintText: "Search Product",
              prefixIcon: Icon(
                Icons.search,
                color: kDarkPrimaryColor,
              ),
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 20, vertical: 9))),
    );
  }
}
