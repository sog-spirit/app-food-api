import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../constants.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(50)),
              border: Border.all(color: ksecondaryColor.withOpacity(0.32))),
          child: TextField(
            decoration: InputDecoration(
                border: InputBorder.none,
                icon: SvgPicture.asset("assets/icons/search.svg"),
                hintText: "Search Here",
                hintStyle: TextStyle(color: ksecondaryColor)),
          ),
        )
      ],
    );
  }
}
