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
      width: MediaQuery.of(context).size.width * 1,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 195, 189, 189).withOpacity(0.1),
          borderRadius: BorderRadius.circular(15)),
      child: Center(
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
      ),
    );
  }
}
