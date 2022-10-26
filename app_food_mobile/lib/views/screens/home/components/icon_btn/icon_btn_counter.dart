import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../constants.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfItems = 0,
    required this.press,
  }) : super(key: key);
  final String svgSrc;
  final int numOfItems;
  final GestureTapCallback press;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: press,
      borderRadius: BorderRadius.circular(50),
      child: Stack(children: [
        if (numOfItems != 0)
          Positioned(
            right: 0,
            child: Container(
              height: 16,
              width: 16,
              decoration: BoxDecoration(
                  color: Color(0xFFFF4848), shape: BoxShape.circle),
              child: Center(
                child: Text(
                  "${numOfItems}",
                  style: TextStyle(
                      fontSize: 10,
                      height: 1,
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        Container(
          padding: EdgeInsets.all(8),
          height: 46,
          width: 46,
          decoration: BoxDecoration(
              color: kDarkPrimaryColor.withOpacity(0.1),
              shape: BoxShape.circle),
          child: SvgPicture.asset(
            svgSrc,
            width: 5,
            height: 5,
            fit: BoxFit.scaleDown,
          ),
        ),
      ]),
    );
  }
}
