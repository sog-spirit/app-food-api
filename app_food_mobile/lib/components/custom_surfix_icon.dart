import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({super.key, required this.svgIcon});
  final String svgIcon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: SvgPicture.asset(
        svgIcon,
        height: 19,
      ),
    );
  }
}
