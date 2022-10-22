import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../models/product.dart';

class ItemCard extends StatelessWidget {
  final Product product;
  final void Function() press;
  const ItemCard({
    Key? key,
    required this.product,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(left: 20, right: 15, top: 20, bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 30,
                color: Color(0xFFB0CCE1).withOpacity(0.32))
          ]),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: press,
          child: Column(children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
              child: Image.network('http://192.168.1.135:8000/${product.image}',
                  width: 150, fit: BoxFit.fill),
            ),
            Text(product.name + "trương"),
            SizedBox(height: 12),
            Text(
              TiengViet.parse('Gà rán (3 miếng)'),
              style: TextStyle(fontSize: 12),
            )
          ]),
        ),
      ),
    );
  }
}
